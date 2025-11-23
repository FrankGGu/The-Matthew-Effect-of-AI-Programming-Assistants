#include <iostream>
#include <vector>
#include <deque>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<long long> resultsArray(vector<int>& nums, int k) {
        vector<long long> result;
        deque<int> dq;
        for (int i = 0; i < nums.size(); ++i) {
            while (!dq.empty() && nums[i] > nums[dq.back()]) {
                dq.pop_back();
            }
            dq.push_back(i);
            if (dq.front() <= i - k) {
                dq.pop_front();
            }
            if (i >= k - 1) {
                result.push_back(nums[dq.front()]);
            }
        }
        return result;
    }
};