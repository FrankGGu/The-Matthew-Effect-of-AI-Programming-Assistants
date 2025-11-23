#include <vector>
#include <deque>
#include <climits>

using namespace std;

class Solution {
public:
    vector<int> maxAndMin(vector<int>& nums, int k) {
        vector<int> result(2);
        if (nums.empty() || k <= 0) return result;

        int n = nums.size();
        deque<int> maxDeque, minDeque;
        long long maxSum = LLONG_MIN, minSum = LLONG_MAX;
        long long sum = 0;

        for (int i = 0; i < n; ++i) {
            sum += nums[i];

            while (!maxDeque.empty() && nums[i] >= nums[maxDeque.back()]) {
                maxDeque.pop_back();
            }
            maxDeque.push_back(i);

            while (!minDeque.empty() && nums[i] <= nums[minDeque.back()]) {
                minDeque.pop_back();
            }
            minDeque.push_back(i);

            if (i >= k - 1) {
                if (maxDeque.front() <= i - k) {
                    maxDeque.pop_front();
                }
                if (minDeque.front() <= i - k) {
                    minDeque.pop_front();
                }

                long long currentMax = nums[maxDeque.front()];
                long long currentMin = nums[minDeque.front()];

                if (i >= k) {
                    sum -= nums[i - k];
                }

                if (i >= k - 1) {
                    maxSum = max(maxSum, sum);
                    minSum = min(minSum, sum);
                }
            }
        }

        result[0] = maxSum == LLONG_MIN ? 0 : maxSum;
        result[1] = minSum == LLONG_MAX ? 0 : minSum;
        return result;
    }
};