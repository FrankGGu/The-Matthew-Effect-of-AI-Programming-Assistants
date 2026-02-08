#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minCostToMoveChips(int n, vector<int>& position) {
        int even = 0;
        int odd = 0;
        for (int i = 0; i < n; ++i) {
            if (position[i] % 2 == 0) {
                ++even;
            } else {
                ++odd;
            }
        }
        return min(even, odd);
    }
};