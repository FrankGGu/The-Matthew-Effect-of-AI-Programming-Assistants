#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int getMaximumConsecutive(int n, std::vector<int>& coins) {
        std::sort(coins.begin(), coins.end());
        int res = 0;
        for (int coin : coins) {
            if (coin <= res + 1) {
                res += coin;
            } else {
                break;
            }
        }
        return res + 1;
    }
};