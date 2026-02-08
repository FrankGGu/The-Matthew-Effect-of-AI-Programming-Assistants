#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool xorGame(vector<int>& nums) {
        int xorSum = 0;
        for (int num : nums) {
            xorSum ^= num;
        }
        return xorSum == 0;
    }
};