#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    vector<long long> maxSum(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> result(n - k + 1);
        priority_queue<int> pq;
        long long currentSum = 0;

        for (int i = 0; i < n; ++i) {
            pq.push(nums[i]);
            currentSum += nums[i];

            if (pq.size() > k) {
                currentSum -= pq.top();
                pq.pop();
            }

            if (pq.size() == k) {
                result[i - k + 1] = currentSum;
            }
        }
        return result;
    }

    vector<long long> minSum(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> result(n - k + 1);
        priority_queue<int, vector<int>, greater<int>> pq;
        long long currentSum = 0;

        for (int i = 0; i < n; ++i) {
            pq.push(nums[i]);
            currentSum += nums[i];

            if (pq.size() > k) {
                currentSum -= pq.top();
                pq.pop();
            }

            if (pq.size() == k) {
                result[i - k + 1] = currentSum;
            }
        }
        return result;
    }
};