#include <iostream>
#include <vector>
#include <stack>
#include <numeric>

using namespace std;

class Solution {
public:
    int maxSubarrayMinProduct(vector<int>& nums) {
        int n = nums.size();
        vector<long long> left(n, -1);
        vector<long long> right(n, n);

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

        long long maxProduct = 0;
        for (int i = 0; i < n; ++i) {
            long long l = left[i] + 1;
            long long r = right[i] - 1;
            long long sum = 0;
            for (int j = l; j <= r; ++j) {
                sum += nums[j];
            }
            maxProduct = max(maxProduct, sum * nums[i]);
        }

        return static_cast<int>(maxProduct);
    }
};