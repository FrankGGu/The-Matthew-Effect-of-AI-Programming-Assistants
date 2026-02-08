#include <iostream>
#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countGreatPartitions(vector<int>& nums) {
        int MOD = 1e9 + 7;
        int n = nums.size();
        sort(nums.begin(), nums.end());

        vector<long long> prefix(n, 0);
        prefix[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            prefix[i] = prefix[i - 1] + nums[i];
        }

        vector<long long> suffix(n, 0);
        suffix[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            suffix[i] = suffix[i + 1] + nums[i];
        }

        unordered_map<long long, int> count;
        for (int i = 0; i < n; ++i) {
            count[prefix[i]]++;
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            long long leftSum = prefix[i];
            long long rightSum = suffix[i + 1];
            if (leftSum > rightSum) {
                result = (result + count[leftSum]) % MOD;
            }
        }

        return result;
    }
};