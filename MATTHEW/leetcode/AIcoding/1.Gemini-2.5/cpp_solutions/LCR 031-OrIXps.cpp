#include <list>
#include <unordered_map>
#include <utility>

class LRUCache {
private:
    int capacity;
    std::list<std::pair<int, int>> cacheList; // Stores {key, value}
    std::unordered_map<int, std::list<std::pair<int, int>>::iterator> cacheMap; // Maps key to iterator in cacheList

    void moveToFront(std::unordered_map<int, std::list<std::pair<int, int>>::iterator>::iterator map_it) {
        cacheList.splice(cacheList.begin(), cacheList, map_it->second);
    }

public:
    LRUCache(int capacity) {
        this->capacity = capacity;
    }

    int get(int key) {
        auto it = cacheMap.find(key);
        if (it == cacheMap.end()) {
            return -1;
        }

        moveToFront(it);

        return it->second->second;
    }

    void put(int key, int value) {
        auto it = cacheMap.find(key);

        if (it != cacheMap.end()) {
            it->second->second = value;
            moveToFront(it);
        } else {
            if (cacheList.size() == capacity) {
                int lru_key = cacheList.back().first;
                cacheList.pop_back();
                cacheMap.erase(lru_key);
            }

            cacheList.push_front({key, value});
            cacheMap[key] = cacheList.begin();
        }
    }
};