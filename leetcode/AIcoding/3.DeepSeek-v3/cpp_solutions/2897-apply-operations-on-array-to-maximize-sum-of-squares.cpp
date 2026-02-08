#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxSum(vector<int>& nums, int k) {
        vector<int> bits(31, 0);
        for (int num : nums) {
            for (int i = 0; i < 31; ++i) {
                if (num & (1 << i)) {
                    bits[i]++;
                }
            }
        }

        long long res = 0;
        const int MOD = 1e9 + 7;
        for (int i = 0; i < k; ++i) {
            long long num = 0;
            for (int j = 0; j < 31; ++j) {
                if (bits[j] > 0) {
                    num |= (1 << j);
                    bits[j]--;
                }
            }
            res = (res + num * num) % MOD;
        }
        return res;
    }
};