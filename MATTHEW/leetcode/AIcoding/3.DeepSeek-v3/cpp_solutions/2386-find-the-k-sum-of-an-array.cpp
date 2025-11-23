#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long kSum(vector<int>& nums, int k) {
        long long max_sum = 0;
        for (int& num : nums) {
            if (num > 0) {
                max_sum += num;
            } else {
                num = -num;
            }
        }
        sort(nums.begin(), nums.end());

        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
        pq.push({0, 0});

        while (--k) {
            auto [sum, i] = pq.top();
            pq.pop();
            if (i < nums.size()) {
                pq.push({sum + nums[i], i + 1});
                if (i > 0) {
                    pq.push({sum + nums[i] - nums[i - 1], i + 1});
                }
            }
        }

        return max_sum - pq.top().first;
    }
};