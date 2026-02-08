#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countAlternatingSubarrays(vector<int>& nums) {
        int count = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            int j = i;
            while (j + 1 < n && nums[j] != nums[j + 1]) {
                ++j;
            }
            int length = j - i + 1;
            count += length * (length + 1) / 2;
            i = j;
        }
        return count;
    }
};