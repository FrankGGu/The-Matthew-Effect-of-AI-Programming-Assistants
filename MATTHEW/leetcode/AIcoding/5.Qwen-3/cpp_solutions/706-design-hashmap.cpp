#include <iostream>
#include <vector>

class Solution {
private:
    std::vector<std::vector<int>> map;
    int size;

public:
    Solution() {
        size = 10000;
        map.resize(size);
    }

    void put(int key, int value) {
        int index = key % size;
        for (auto& pair : map[index]) {
            if (pair[0] == key) {
                pair[1] = value;
                return;
            }
        }
        map[index].push_back({key, value});
    }

    int get(int key) {
        int index = key % size;
        for (const auto& pair : map[index]) {
            if (pair[0] == key) {
                return pair[1];
            }
        }
        return -1;
    }

    void remove(int key) {
        int index = key % size;
        for (auto it = map[index].begin(); it != map[index].end(); ++it) {
            if (it->at(0) == key) {
                map[index].erase(it);
                return;
            }
        }
    }
};