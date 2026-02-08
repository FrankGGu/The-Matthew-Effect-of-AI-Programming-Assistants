#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findMinimumOperations(vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] % 3 != 0) {
                count++;
            }
        }
        return count;
    }
};