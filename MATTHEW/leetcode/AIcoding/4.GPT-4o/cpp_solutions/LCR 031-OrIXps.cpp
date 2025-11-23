#include <unordered_map>
#include <list>

class LRUCache {
public:
    LRUCache(int capacity) : cap(capacity) {}

    int get(int key) {
        if (cache.find(key) == cache.end()) {
            return -1;
        }
        else {
            update(key);
            return cache[key]->second;
        }
    }

    void put(int key, int value) {
        if (cache.find(key) != cache.end()) {
            update(key);
            cache[key]->second = value;
        }
        else {
            if (cache.size() == cap) {
                cache.erase(usage.back().first);
                usage.pop_back();
            }
            usage.push_front({key, value});
            cache[key] = usage.begin();
        }
    }

private:
    void update(int key) {
        auto it = cache[key];
        usage.erase(it);
        usage.push_front({key, it->second});
        cache[key] = usage.begin();
    }

    int cap;
    std::list<std::pair<int, int>> usage;
    std::unordered_map<int, std::list<std::pair<int, int>>::iterator> cache;
};