#include <vector>

using namespace std;

class Solution {
public:
    int semiOrderedPermutation(vector<int>& nums) {
        int n = nums.size();
        int first_pos = -1;
        int last_pos = -1;

        for (int i = 0; i < n; ++i) {
            if (nums[i] == 1) {
                first_pos = i;
            }
            if (nums[i] == n) {
                last_pos = i;
            }
        }

        int ans = first_pos + (n - 1 - last_pos);
        if (first_pos > last_pos) {
            ans--;
        }

        return ans;
    }
};