#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSumRangeQuery(vector<int>& nums, vector<vector<int>>& requests) {
        int n = nums.size();
        vector<int> freq(n, 0);
        for (auto& request : requests) {
            int start = request[0];
            int end = request[1];
            freq[start]++;
            if (end + 1 < n) {
                freq[end + 1]--;
            }
        }
        for (int i = 1; i < n; ++i) {
            freq[i] += freq[i - 1];
        }
        sort(nums.begin(), nums.end());
        sort(freq.begin(), freq.end());
        long long maxSum = 0;
        long long mod = 1e9 + 7;
        for (int i = 0; i < n; ++i) {
            maxSum = (maxSum + (long long)nums[i] * freq[i]) % mod;
        }
        return (int)maxSum;
    }
};