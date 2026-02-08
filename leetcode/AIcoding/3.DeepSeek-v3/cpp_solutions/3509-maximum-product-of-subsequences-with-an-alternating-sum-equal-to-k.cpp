#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumProduct(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int i = 0;

        while (k > 0) {
            if (i < n - 1 && nums[i] == nums[i + 1]) {
                i++;
            } else {
                if (i == n - 1) {
                    nums[i]++;
                    k--;
                    i = 0;
                } else {
                    int diff = nums[i + 1] - nums[i];
                    int add = min(diff, k);
                    nums[i] += add;
                    k -= add;
                    i = 0;
                }
            }
        }

        long long product = 1;
        const int MOD = 1e9 + 7;
        for (int num : nums) {
            product = (product * num) % MOD;
        }

        return product;
    }
};