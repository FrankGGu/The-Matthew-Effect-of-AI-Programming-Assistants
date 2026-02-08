#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int maxConsecutive(int n, std::vector<int>& special) {
        std::sort(special.begin(), special.end());
        int maxConsec = 0;
        int prev = 0;
        for (int& s : special) {
            maxConsec = std::max(maxConsec, s - prev - 1);
            prev = s;
        }
        maxConsec = std::max(maxConsec, n - prev);
        return maxConsec;
    }
};