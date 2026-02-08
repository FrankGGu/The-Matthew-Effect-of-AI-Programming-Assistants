#include <iostream>
#include <vector>
#include <list>
#include <unordered_map>

class Solution {
private:
    int capacity;
    std::list<std::pair<int, int>> cache;
    std::unordered_map<int, std::list<std::pair<int, int>>::iterator> map;

    void moveToHead(std::list<std::pair<int, int>>::iterator it) {
        int key = it->first;
        int value = it->second;
        cache.erase(it);
        cache.push_front({key, value});
        map[key] = cache.begin();
    }

public:
    Solution(int capacity) : capacity(capacity) {}

    int get(int key) {
        if (map.find(key) == map.end()) {
            return -1;
        }
        auto it = map[key];
        moveToHead(it);
        return it->second;
    }

    void put(int key, int value) {
        if (map.find(key) != map.end()) {
            auto it = map[key];
            moveToHead(it);
            it->second = value;
        } else {
            if (cache.size() >= capacity) {
                int lastKey = cache.back().first;
                map.erase(lastKey);
                cache.pop_back();
            }
            cache.push_front({key, value});
            map[key] = cache.begin();
        }
    }
};