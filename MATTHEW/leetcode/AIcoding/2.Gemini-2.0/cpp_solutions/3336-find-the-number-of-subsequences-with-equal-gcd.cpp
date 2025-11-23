#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int countDifferentSubsequenceGCDs(vector<int>& nums) {
        int max_val = 0;
        for (int num : nums) {
            max_val = max(max_val, num);
        }

        vector<bool> present(max_val + 1, false);
        for (int num : nums) {
            present[num] = true;
        }

        int count = 0;
        for (int i = 1; i <= max_val; ++i) {
            int gcd_val = 0;
            for (int j = i; j <= max_val; j += i) {
                if (present[j]) {
                    gcd_val = (gcd_val == 0) ? j : gcd(gcd_val, j);
                }
            }
            if (gcd_val == i) {
                count++;
            }
        }

        return count;
    }
};