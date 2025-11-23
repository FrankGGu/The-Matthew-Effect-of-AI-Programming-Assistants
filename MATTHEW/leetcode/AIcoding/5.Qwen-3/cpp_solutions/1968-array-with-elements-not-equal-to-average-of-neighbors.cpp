#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> rearrangeArray(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        vector<int> result(nums.size());
        int left = 0, right = nums.size() - 1;
        bool flag = true;
        for (int i = 0; i < nums.size(); ++i) {
            if (flag) {
                result[i] = nums[left++];
            } else {
                result[i] = nums[right--];
            }
            flag = !flag;
        }
        return result;
    }
};