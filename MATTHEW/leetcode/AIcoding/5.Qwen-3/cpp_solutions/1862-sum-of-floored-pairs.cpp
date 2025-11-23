#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int sumOfFlooredPairs(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        int max_num = *max_element(nums.begin(), nums.end());
        vector<int> freq(max_num + 1, 0);
        for (int num : nums) {
            freq[num]++;
        }
        vector<long long> prefix_sum(max_num + 2, 0);
        for (int i = 1; i <= max_num; ++i) {
            prefix_sum[i] = (prefix_sum[i - 1] + freq[i]) % MOD;
        }
        long long result = 0;
        for (int a = 1; a <= max_num; ++a) {
            if (freq[a] == 0) continue;
            for (int b = 1; b <= max_num; ++b) {
                if (freq[b] == 0) continue;
                int q = a / b;
                int left = b * q;
                int right = min(b * (q + 1) - 1, max_num);
                long long count = (prefix_sum[right] - prefix_sum[left - 1]) % MOD;
                result = (result + (long long)freq[a] * freq[b] * count) % MOD;
            }
        }
        return result;
    }
};