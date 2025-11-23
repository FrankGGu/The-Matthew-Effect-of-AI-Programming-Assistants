#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int findXOROfAll(int n) {
        std::unordered_map<int, int> count;
        for (int i = 1; i <= n; ++i) {
            ++count[i];
        }
        int result = 0;
        for (const auto& pair : count) {
            if (pair.second == 2) {
                result ^= pair.first;
            }
        }
        return result;
    }
};