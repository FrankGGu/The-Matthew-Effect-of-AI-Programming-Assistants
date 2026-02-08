#include <unordered_map>
#include <list>

using namespace std;

class LFUCache {
public:
    LFUCache(int capacity) : capacity_(capacity), min_freq_(0) {}

    int get(int key) {
        if (key_to_node_.find(key) == key_to_node_.end()) {
            return -1;
        }

        auto node = key_to_node_[key];
        int val = node->val;
        int freq = node->freq;

        freq_to_list_[freq].erase(node);
        if (freq_to_list_[freq].empty()) {
            freq_to_list_.erase(freq);
            if (min_freq_ == freq) {
                min_freq_++;
            }
        }

        freq++;
        freq_to_list_[freq].push_front({key, val, freq});
        key_to_node_[key] = freq_to_list_[freq].begin();

        return val;
    }

    void put(int key, int value) {
        if (capacity_ <= 0) {
            return;
        }

        if (key_to_node_.find(key) != key_to_node_.end()) {
            auto node = key_to_node_[key];
            int freq = node->freq;

            freq_to_list_[freq].erase(node);
            if (freq_to_list_[freq].empty()) {
                freq_to_list_.erase(freq);
                if (min_freq_ == freq) {
                    min_freq_++;
                }
            }

            freq++;
            freq_to_list_[freq].push_front({key, value, freq});
            key_to_node_[key] = freq_to_list_[freq].begin();
            key_to_node_[key]->val = value; 
        } else {
            if (key_to_node_.size() == capacity_) {
                int lfu_key = freq_to_list_[min_freq_].back().key;
                key_to_node_.erase(lfu_key);
                freq_to_list_[min_freq_].pop_back();
                if (freq_to_list_[min_freq_].empty()) {
                    freq_to_list_.erase(min_freq_);
                }
            }

            min_freq_ = 1;
            freq_to_list_[min_freq_].push_front({key, value, min_freq_});
            key_to_node_[key] = freq_to_list_[min_freq_].begin();
        }
    }

private:
    struct Node {
        int key;
        int val;
        int freq;
    };

    int capacity_;
    int min_freq_;
    unordered_map<int, list<Node>::iterator> key_to_node_;
    unordered_map<int, list<Node>> freq_to_list_;
};