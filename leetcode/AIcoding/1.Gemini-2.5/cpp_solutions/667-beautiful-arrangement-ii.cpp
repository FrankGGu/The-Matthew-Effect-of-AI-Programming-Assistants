#include <vector>
#include <numeric>
#include <cmath>

class Solution {
public:
    std::vector<int> constructArray(int n, int k) {
        std::vector<int> ans;
        int left = 1;
        int right = k + 1;

        for (int i = 0; i <= k; ++i) {
            if (i % 2 == 0) {
                ans.push_back(left);
                left++;
            } else {
                ans.push_back(right);
                right--;
            }
        }

        for (int i = k + 2; i <= n; ++i) {
            ans.push_back(i);
        }

        return ans;
    }
};