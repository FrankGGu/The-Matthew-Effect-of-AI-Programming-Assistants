#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int maxFrequencyScore(vector<int>& nums, long long k) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int left = 0;
        int max_len = 0;

        for (int right = 0; right < n; ++right) {
            long long cost = 0;
            int mid = left + (right - left) / 2;
            cost = (long long)nums[mid] * (mid - left) - (prefix[mid] - prefix[left]);
            cost += (prefix[right + 1] - prefix[mid + 1]) - (long long)nums[mid] * (right - mid);

            while (cost > k) {
                left++;
                mid = left + (right - left) / 2;
                cost = (long long)nums[mid] * (mid - left) - (prefix[mid] - prefix[left]);
                cost += (prefix[right + 1] - prefix[mid + 1]) - (long long)nums[mid] * (right - mid);
            }

            max_len = max(max_len, right - left + 1);
        }

        return max_len;
    }
};