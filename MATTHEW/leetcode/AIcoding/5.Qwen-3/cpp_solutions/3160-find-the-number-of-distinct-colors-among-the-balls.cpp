#include <iostream>
#include <vector>
#include <unordered_set>

class Solution {
public:
    int countDistinctColors(int n, std::vector<int>& colors) {
        std::unordered_set<int> uniqueColors;
        for (int i = 0; i < n; ++i) {
            uniqueColors.insert(colors[i]);
        }
        return uniqueColors.size();
    }
};