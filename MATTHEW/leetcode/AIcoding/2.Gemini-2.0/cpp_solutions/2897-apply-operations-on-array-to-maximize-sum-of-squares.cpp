#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumSumOfSquares(vector<int>& nums) {
        int n = nums.size();
        int zeros = 0, ones = 0;
        for (int num : nums) {
            for (int i = 0; i < 31; ++i) {
                if ((num >> i) & 1) {
                    ones++;
                } else {
                    zeros++;
                }
            }
        }

        vector<int> res(n, 0);
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < 31; ++j) {
                if (ones > 0) {
                    res[i] |= (1 << j);
                    ones--;
                } else {
                    break;
                }
            }
        }

        long long ans = 0;
        for (int num : res) {
            ans += (long long)num * num;
        }

        return (int)(ans % 1000000007);
    }
};