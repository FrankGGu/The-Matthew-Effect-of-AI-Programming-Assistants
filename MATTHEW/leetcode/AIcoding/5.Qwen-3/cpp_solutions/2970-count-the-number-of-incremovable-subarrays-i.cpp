#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfIncremovableSubarrays(vector<int>& nums) {
        int n = nums.size();
        int count = 0;

        for (int i = 0; i < n; i++) {
            int minVal = nums[i];
            for (int j = i; j < n; j++) {
                if (nums[j] < minVal) break;
                minVal = nums[j];
                count++;
            }
        }

        return count;
    }
};