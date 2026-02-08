#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
private:
    map<int, vector<int>> indexMap;
    vector<int> nums;

public:
    Solution(vector<int>& nums) {
        this->nums = nums;
        for (int i = 0; i < nums.size(); ++i) {
            indexMap[nums[i]].push_back(i);
        }
    }

    int get(int x) {
        int result = 0;
        for (int i = 0; i < indexMap[x].size(); ++i) {
            int idx = indexMap[x][i];
            if (idx > 0) result += nums[idx - 1];
            if (idx < nums.size() - 1) result += nums[idx + 1];
        }
        return result;
    }
};