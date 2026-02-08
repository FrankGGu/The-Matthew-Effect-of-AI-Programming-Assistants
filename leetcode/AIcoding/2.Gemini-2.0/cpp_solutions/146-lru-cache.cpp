#include <unordered_map>
#include <list>

using namespace std;

class LRUCache {
private:
    int capacity;
    unordered_map<int, int> cache;
    list<int> lru;
    unordered_map<int, list<int>::iterator> pos;

public:
    LRUCache(int capacity) {
        this->capacity = capacity;
    }

    int get(int key) {
        if (cache.find(key) == cache.end()) {
            return -1;
        }
        lru.erase(pos[key]);
        lru.push_front(key);
        pos[key] = lru.begin();
        return cache[key];
    }

    void put(int key, int value) {
        if (cache.find(key) != cache.end()) {
            lru.erase(pos[key]);
            lru.push_front(key);
            pos[key] = lru.begin();
            cache[key] = value;
        } else {
            if (cache.size() == capacity) {
                int last = lru.back();
                cache.erase(last);
                pos.erase(last);
                lru.pop_back();
            }
            lru.push_front(key);
            pos[key] = lru.begin();
            cache[key] = value;
        }
    }
};