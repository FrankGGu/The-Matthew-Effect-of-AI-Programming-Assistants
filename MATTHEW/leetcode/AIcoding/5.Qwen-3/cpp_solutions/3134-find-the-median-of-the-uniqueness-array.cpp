#include <iostream>
#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    double medianUniqueArray(const std::vector<int>& nums) {
        std::unordered_set<int> unique;
        for (int num : nums) {
            unique.insert(num);
        }
        std::vector<int> uniqueVec(unique.begin(), unique.end());
        std::sort(uniqueVec.begin(), uniqueVec.end());
        int n = uniqueVec.size();
        if (n % 2 == 1) {
            return uniqueVec[n / 2];
        } else {
            return (uniqueVec[(n / 2) - 1] + uniqueVec[n / 2]) / 2.0;
        }
    }
};