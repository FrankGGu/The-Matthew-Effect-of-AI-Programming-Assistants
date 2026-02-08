#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long countPairs(vector<int>& nums, int k) {
        int n = nums.size();
        long long count = 0;
        vector<int> gcd_counts(k + 1, 0);

        for (int i = 0; i < n; ++i) {
            int gcd_val = gcd(nums[i], k);
            for (int j = 1; j <= k; ++j) {
                if ((long long)gcd_val * j % k == 0) {
                    count += gcd_counts[j];
                }
            }
            gcd_counts[gcd_val]++;
        }
        return count;
    }

private:
    int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};