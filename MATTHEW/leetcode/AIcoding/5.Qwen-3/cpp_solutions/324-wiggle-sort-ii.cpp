#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    void wiggleSort(vector<int>& nums) {
        vector<int> temp = nums;
        sort(temp.begin(), temp.end());
        int left = 0, right = nums.size() - 1;
        for (int i = 1; i < nums.size(); i += 2)
            nums[i] = temp[right--];
        for (int i = 0; i < nums.size(); i += 2)
            nums[i] = temp[left++];
    }
};