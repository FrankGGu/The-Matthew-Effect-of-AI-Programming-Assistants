#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    vector<long long> minAndMaxSubarraySums(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        vector<long long> result(2, 0);
        result[0] = LLONG_MAX;
        result[1] = LLONG_MIN;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j <= min(i + k, n); ++j) {
                long long sum = prefix[j] - prefix[i];
                result[0] = min(result[0], sum);
                result[1] = max(result[1], sum);
            }
        }

        return result;
    }
};