#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int operations = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            if (nums[i] == 0) {
                operations++;
                for (int j = i; j < min(i + 3, n); ++j) {
                    nums[j] ^= 1;
                }
            }
        }
        return operations;
    }
};