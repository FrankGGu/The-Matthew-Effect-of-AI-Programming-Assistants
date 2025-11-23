#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minOperations(vector<int>& nums, vector<int>& queries) {
        sort(nums.begin(), nums.end());
        vector<long long> prefix_sum(nums.size() + 1, 0);
        for (int i = 0; i < nums.size(); ++i) {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        vector<long long> result;
        for (int query : queries) {
            int left = 0, right = nums.size() - 1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (nums[mid] < query) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            long long smaller_count = left;
            long long larger_count = nums.size() - left;

            long long smaller_sum = (smaller_count > 0) ? prefix_sum[left] : 0;
            long long larger_sum = prefix_sum[nums.size()] - prefix_sum[left];

            long long smaller_ops = (long long)query * smaller_count - smaller_sum;
            long long larger_ops = larger_sum - (long long)query * larger_count;

            result.push_back(smaller_ops + larger_ops);
        }

        return result[0];
    }
};