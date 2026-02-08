#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeGreatness(vector<int>& nums) {
        vector<int> sorted = nums;
        sort(sorted.begin(), sorted.end());
        int i = 0, j = 0;
        while (i < nums.size() && j < nums.size()) {
            if (nums[i] == sorted[j]) {
                i++;
                j++;
            } else {
                j++;
            }
        }
        return i;
    }
};