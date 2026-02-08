#include <iostream>
#include <vector>
#include <unordered_map>
#include <cstdlib>

class Solution {
private:
    int n;
    int m;
    int total;
    std::unordered_map<int, int> map;

public:
    Solution(int n, int m) : n(n), m(m), total(n * m) {}

    int flip() {
        int randNum = rand() % total;
        total--;
        if (map.find(randNum) != map.end()) {
            return map[randNum];
        }
        return randNum;
    }

    void reset() {
        map.clear();
        total = n * m;
    }
};