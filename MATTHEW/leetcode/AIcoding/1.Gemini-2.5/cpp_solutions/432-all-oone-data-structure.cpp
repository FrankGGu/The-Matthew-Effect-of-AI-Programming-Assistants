#include <string>
#include <unordered_map>
#include <unordered_set>
#include <list>
#include <iterator>

class AllOne {
private:
    struct Bucket {
        int count;
        std::unordered_set<std::string> keys;
    };

    std::list<Bucket> buckets;
    std::unordered_map<std::string, std::list<Bucket>::iterator> keyToBucketIter;

public:
    AllOne() {

    }

    void inc(std::string key) {
        if (keyToBucketIter.find(key) == keyToBucketIter.end()) {
            if (buckets.empty() || buckets.front().count != 1) {
                buckets.push_front({1, {key}});
            } else {
                buckets.front().keys.insert(key);
            }
            keyToBucketIter[key] = buckets.begin();
        } else {
            auto curr_it = keyToBucketIter[key];
            int count = curr_it->count;

            auto next_it = std::next(curr_it);
            if (next_it == buckets.end() || next_it->count != count + 1) {
                next_it = buckets.insert(next_it, {count + 1, {key}});
            } else {
                next_it->keys.insert(key);
            }

            keyToBucketIter[key] = next_it;

            curr_it->keys.erase(key);
            if (curr_it->keys.empty()) {
                buckets.erase(curr_it);
            }
        }
    }

    void dec(std::string key) {
        if (keyToBucketIter.find(key) == keyToBucketIter.end()) {
            return;
        }

        auto curr_it = keyToBucketIter[key];
        int count = curr_it->count;

        if (count > 1) {
            auto prev_it = std::prev(curr_it);
            if (curr_it == buckets.begin() || prev_it->count != count - 1) {
                auto new_it = buckets.insert(curr_it, {count - 1, {key}});
                keyToBucketIter[key] = new_it;
            } else {
                prev_it->keys.insert(key);
                keyToBucketIter[key] = prev_it;
            }
        } else {
            keyToBucketIter.erase(key);
        }

        curr_it->keys.erase(key);
        if (curr_it->keys.empty()) {
            buckets.erase(curr_it);
        }
    }

    std::string getMaxKey() {
        if (buckets.empty()) {
            return "";
        }
        return *buckets.back().keys.begin();
    }

    std::string getMinKey() {
        if (buckets.empty()) {
            return "";
        }
        return *buckets.front().keys.begin();
    }
};