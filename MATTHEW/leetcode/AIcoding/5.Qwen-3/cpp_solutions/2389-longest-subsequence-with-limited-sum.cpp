#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> answerQueries(vector<int>& nums, vector<int>& queries) {
        sort(nums.begin(), nums.end());
        for (int i = 1; i < nums.size(); ++i) {
            nums[i] += nums[i - 1];
        }
        vector<int> result;
        for (int q : queries) {
            int count = 0;
            for (int num : nums) {
                if (num <= q) {
                    ++count;
                } else {
                    break;
                }
            }
            result.push_back(count);
        }
        return result;
    }
};