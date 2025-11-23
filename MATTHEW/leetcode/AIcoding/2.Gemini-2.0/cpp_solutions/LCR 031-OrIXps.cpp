#include <unordered_map>
#include <list>

using namespace std;

class LRUCache {
private:
    int capacity;
    unordered_map<int, int> cache;
    list<int> lruList;
    unordered_map<int, list<int>::iterator> pos;

public:
    LRUCache(int capacity) : capacity(capacity) {}

    int get(int key) {
        if (cache.find(key) == cache.end()) {
            return -1;
        }

        lruList.erase(pos[key]);
        lruList.push_front(key);
        pos[key] = lruList.begin();

        return cache[key];
    }

    void put(int key, int value) {
        if (cache.find(key) != cache.end()) {
            lruList.erase(pos[key]);
        }

        cache[key] = value;
        lruList.push_front(key);
        pos[key] = lruList.begin();

        if (lruList.size() > capacity) {
            int last = lruList.back();
            lruList.pop_back();
            cache.erase(last);
            pos.erase(last);
        }
    }
};