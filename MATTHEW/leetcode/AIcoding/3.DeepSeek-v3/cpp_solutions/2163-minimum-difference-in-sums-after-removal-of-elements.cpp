#include <vector>
#include <queue>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    long long minimumDifference(vector<int>& nums) {
        int n = nums.size() / 3;

        vector<long long> prefix(nums.size(), 0);
        priority_queue<int> maxHeap;
        long long sum = 0;
        for (int i = 0; i < 2 * n; ++i) {
            maxHeap.push(nums[i]);
            sum += nums[i];
            if (maxHeap.size() > n) {
                sum -= maxHeap.top();
                maxHeap.pop();
            }
            if (maxHeap.size() == n) {
                prefix[i] = sum;
            }
        }

        vector<long long> suffix(nums.size(), 0);
        priority_queue<int, vector<int>, greater<int>> minHeap;
        sum = 0;
        for (int i = 3 * n - 1; i >= n; --i) {
            minHeap.push(nums[i]);
            sum += nums[i];
            if (minHeap.size() > n) {
                sum -= minHeap.top();
                minHeap.pop();
            }
            if (minHeap.size() == n) {
                suffix[i] = sum;
            }
        }

        long long res = LLONG_MAX;
        for (int i = n - 1; i < 2 * n; ++i) {
            res = min(res, prefix[i] - suffix[i + 1]);
        }

        return res;
    }
};