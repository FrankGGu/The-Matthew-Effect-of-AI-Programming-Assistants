#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countDifferentSubsequenceGCDs(vector<int>& nums) {
        int max_num = *max_element(nums.begin(), nums.end());
        vector<bool> present(max_num + 1, false);
        for (int num : nums) {
            present[num] = true;
        }

        int count = 0;
        for (int i = 1; i <= max_num; ++i) {
            int gcd_val = 0;
            for (int j = i; j <= max_num; j += i) {
                if (present[j]) {
                    gcd_val = gcd(gcd_val, j);
                }
            }
            if (gcd_val == i) {
                count++;
            }
        }

        return count;
    }
};