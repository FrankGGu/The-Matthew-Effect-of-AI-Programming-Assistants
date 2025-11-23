#include <iostream>
#include <vector>
#include <deque>

using namespace std;

class Solution {
public:
    vector<long long> pow2(long long x) {
        return {x * x};
    }

    vector<long long> resultsArray(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> result;
        deque<int> dq;
        for (int i = 0; i < n; ++i) {
            while (!dq.empty() && nums[i] > nums[dq.back()]) {
                dq.pop_back();
            }
            dq.push_back(i);
            if (dq.front() <= i - k) {
                dq.pop_front();
            }
            if (i >= k - 1) {
                result.push_back(pow2(nums[dq.front()]));             }
        }
        return result;
    }
};