#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProduct(vector<int>& nums, int k) {
        int n = nums.size();
        long long max_product = -1;
        long long mod = 1e9 + 7;

        for (int i = 0; i < (1 << n); ++i) {
            vector<int> subsequence;
            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    subsequence.push_back(nums[j]);
                }
            }

            if (subsequence.empty()) continue;

            long long alternating_sum = 0;
            for (int j = 0; j < subsequence.size(); ++j) {
                if (j % 2 == 0) {
                    alternating_sum += subsequence[j];
                } else {
                    alternating_sum -= subsequence[j];
                }
            }

            if (alternating_sum == k) {
                long long product = 1;
                for (int num : subsequence) {
                    product = (product * num) % mod;
                }
                max_product = max(max_product, product);
            }
        }

        return (int)max_product;
    }
};