#include <list>
#include <unordered_map>

class LRUCache {
private:
    std::list<std::pair<int, int>> cacheList;
    std::unordered_map<int, std::list<std::pair<int, int>>::iterator> cacheMap;
    int capacity;

    void moveToFront(std::list<std::pair<int, int>>::iterator it) {
        cacheList.splice(cacheList.begin(), cacheList, it);
    }

public:
    LRUCache(int capacity) {
        this->capacity = capacity;
    }

    int get(int key) {
        if (cacheMap.find(key) == cacheMap.end()) {
            return -1;
        }

        auto it = cacheMap[key];
        moveToFront(it);

        return it->second;
    }

    void put(int key, int value) {
        if (cacheMap.find(key) != cacheMap.end()) {
            auto it = cacheMap[key];
            it->second = value;
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