#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int sumSubarrayMins(vector<int>& nums) {
        int MOD = 1e9 + 7;
        int n = nums.size();
        vector<int> left(n, -1);
        vector<int> right(n, n);
        stack<int> s;

        for (int i = 0; i < n; ++i) {
            while (!s.empty() && nums[s.top()] >= nums[i]) {
                s.pop();
            }
            if (!s.empty()) {
                left[i] = s.top();
            }
            s.push(i);
        }

        s = stack<int>();

        for (int i = n - 1; i >= 0; --i) {
            while (!s.empty() && nums[s.top()] > nums[i]) {
                s.pop();
            }
            if (!s.empty()) {
                right[i] = s.top();
            }
            s.push(i);
        }

        long long res = 0;
        for (int i = 0; i < n; ++i) {
            res += (long long)(i - left[i]) * (right[i] - i) * nums[i];
            res %= MOD;
        }

        return res;
    }
};