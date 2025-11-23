#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    long long minimumDifference(vector<int>& nums) {
        int n = nums.size() / 3;
        vector<int> left(nums.begin(), nums.begin() + 2 * n);
        vector<int> right(nums.begin() + n, nums.end());

        priority_queue<int> left_pq;
        long long left_sum = 0;
        vector<long long> left_sums(n + 1);
        for (int i = 0; i < 2 * n; ++i) {
            left_pq.push(left[i]);
            left_sum += left[i];
            if (left_pq.size() > n) {
                left_sum -= left_pq.top();
                left_pq.pop();
            }
            if (left_pq.size() == n) {
                left_sums[i - n + 1] = left_sum;
            }
        }

        priority_queue<int, vector<int>, greater<int>> right_pq;
        long long right_sum = 0;
        vector<long long> right_sums(n + 1);
        for (int i = 0; i < 2 * n; ++i) {
            right_pq.push(right[2 * n - 1 - i]);
            right_sum += right[2 * n - 1 - i];
            if (right_pq.size() > n) {
                right_sum -= right_pq.top();
                right_pq.pop();
            }
            if (right_pq.size() == n) {
                right_sums[2 * n - 1 - i] = right_sum;
            }
        }

        long long min_diff = LLONG_MAX;
        for (int i = 0; i <= n; ++i) {
            min_diff = min(min_diff, left_sums[i] - right_sums[i + n]);
        }

        return min_diff;
    }
};