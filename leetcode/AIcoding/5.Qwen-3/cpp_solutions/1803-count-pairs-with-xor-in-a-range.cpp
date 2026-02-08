#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countPairs(int n, vector<int>& nums, int left, int right) {
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if ((nums[i] ^ nums[j]) >= left && (nums[i] ^ nums[j]) <= right) {
                    ++count;
                }
            }
        }
        return count;
    }
};