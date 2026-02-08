#include <unordered_map>
#include <list>
#include <string>
#include <unordered_set>

using namespace std;

class AllOne {
private:
    struct Bucket {
        int count;
        unordered_set<string> keys;
    };
    list<Bucket> buckets;
    unordered_map<string, list<Bucket>::iterator> keyToBucket;

public:
    AllOne() {}

    void inc(string key) {
        if (keyToBucket.find(key) == keyToBucket.end()) {
            if (buckets.empty() || buckets.front().count != 1) {
                buckets.push_front({1, {key}});
            } else {
                buckets.front().keys.insert(key);
            }
            keyToBucket[key] = buckets.begin();
        } else {
            auto current = keyToBucket[key];
            auto next = current;
            ++next;
            if (next == buckets.end() || next->count != current->count + 1) {
                next = buckets.insert(next, {current->count + 1, {}});
            }
            next->keys.insert(key);
            keyToBucket[key] = next;
            current->keys.erase(key);
            if (current->keys.empty()) {
                buckets.erase(current);
            }
        }
    }

    void dec(string key) {
        if (keyToBucket.find(key) == keyToBucket.end()) {
            return;
        }
        auto current = keyToBucket[key];
        if (current->count == 1) {
            keyToBucket.erase(key);
        } else {
            auto prev = current;
            --prev;
            if (current == buckets.begin() || prev->count != current->count - 1) {
                prev = buckets.insert(current, {current->count - 1, {}});
            }
            prev->keys.insert(key);
            keyToBucket[key] = prev;
        }
        current->keys.erase(key);
        if (current->keys.empty()) {
            buckets.erase(current);
        }
    }

    string getMaxKey() {
        return buckets.empty() ? "" : *buckets.back().keys.begin();
    }

    string getMinKey() {
        return buckets.empty() ? "" : *buckets.front().keys.begin();
    }
};