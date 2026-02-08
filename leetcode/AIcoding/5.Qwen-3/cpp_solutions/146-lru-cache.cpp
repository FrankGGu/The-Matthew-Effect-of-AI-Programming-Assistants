#include <iostream>
#include <vector>
#include <list>
#include <unordered_map>

using namespace std;

class Solution {
private:
    int capacity;
    list<pair<int, int>> cache;
    unordered_map<int, list<pair<int, int>>::iterator> map;

public:
    Solution(int capacity) : capacity(capacity) {}

    int get(int key) {
        if (map.find(key) == map.end()) {
            return -1;
        }
        auto it = map[key];
        int value = it->second;
        cache.erase(it);
        cache.push_front({key, value});
        map[key] = cache.begin();
        return value;
    }

    void put(int key, int value) {
        if (map.find(key) != map.end()) {
            cache.erase(map[key]);
        }
        cache.push_front({key, value});
        map[key] = cache.begin();
        if (cache.size() > capacity) {
            int lastKey = cache.back().first;
            cache.pop_back();
            map.erase(lastKey);
        }
    }
};