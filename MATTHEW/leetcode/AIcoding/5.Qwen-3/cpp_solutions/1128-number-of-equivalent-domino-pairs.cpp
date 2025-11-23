#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int numEquivDominoPairs(std::vector<std::vector<int>>& dominoes) {
        std::unordered_map<int, int> count;
        int result = 0;
        for (const auto& d : dominoes) {
            int key = std::min(d[0], d[1]) * 100 + std::max(d[0], d[1]);
            count[key]++;
        }
        for (const auto& c : count) {
            int n = c.second;
            result += n * (n - 1) / 2;
        }
        return result;
    }
};