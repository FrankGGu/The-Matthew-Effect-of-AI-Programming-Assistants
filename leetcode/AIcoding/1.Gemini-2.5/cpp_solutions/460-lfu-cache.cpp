#include <unordered_map>
#include <list>

class LFUCache {
public:
    LFUCache(int capacity) : capacity_(capacity), min_freq_(0) {}

    int get(int key) {
        if (key_to_node_.find(key) == key_to_node_.end()) {
            return -1;
        }

        auto& node = key_to_node_[key];
        int freq = node->freq;
        int val = node->val;

        freq_to_list_[freq].erase(node);
        if (freq_to_list_[freq].empty()) {
            freq_to_list_.erase(freq);
            if (min_freq_ == freq) {
                min_freq_++;
            }
        }

        freq++;
        freq_to_list_[freq].push_front(std::make_shared<Node>(key, val, freq));
        key_to_node_[key] = freq_to_list_[freq].begin();

        return val;
    }

    void put(int key, int value) {
        if (capacity_ <= 0) return;

        if (key_to_node_.find(key) != key_to_node_.end()) {
            auto& node = key_to_node_[key];
            int freq = node->freq;

            freq_to_list_[freq].erase(node);
            if (freq_to_list_[freq].empty()) {
                freq_to_list_.erase(freq);
                if (min_freq_ == freq) {
                    min_freq_++;
                }
            }

            freq++;
            freq_to_list_[freq].push_front(std::make_shared<Node>(key, value, freq));
            key_to_node_[key] = freq_to_list_[freq].begin();
        } else {
            if (key_to_node_.size() >= capacity_) {
                int key_to_remove = freq_to_list_[min_freq_].back()->key;
                key_to_node_.erase(key_to_remove);
                freq_to_list_[min_freq_].pop_back();
                if (freq_to_list_[min_freq_].empty()) {
                    freq_to_list_.erase(min_freq_);
                }
            }

            min_freq_ = 1;
            freq_to_list_[min_freq_].push_front(std::make_shared<Node>(key, value, min_freq_));
            key_to_node_[key] = freq_to_list_[min_freq_].begin();
        }
    }

private:
    struct Node {
        int key;
        int val;
        int freq;

        Node(int key, int val, int freq) : key(key), val(val), freq(freq) {}
    };

    int capacity_;
    int min_freq_;
    std::unordered_map<int, std::list<std::shared_ptr<Node>>::iterator> key_to_node_;
    std::unordered_map<int, std::list<std::shared_ptr<Node>>> freq_to_list_;
};