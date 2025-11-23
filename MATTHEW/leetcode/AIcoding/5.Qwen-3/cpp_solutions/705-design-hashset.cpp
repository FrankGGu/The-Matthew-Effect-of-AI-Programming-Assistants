#include <iostream>
#include <vector>

class Solution {
private:
    std::vector<bool> data;
    int capacity;

public:
    Solution() : capacity(1000001), data(capacity, false) {}

    void add(int key) {
        data[key] = true;
    }

    void remove(int key) {
        data[key] = false;
    }

    bool contains(int key) {
        return data[key];
    }
};