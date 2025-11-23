#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxMarkedIndices(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int i = 0, j = (n + 1) / 2;
        int count = 0;
        while (j < n) {
            if (nums[j] > nums[i]) {
                count++;
                i++;
            }
            j++;
        }
        return count * 2;
    }
};