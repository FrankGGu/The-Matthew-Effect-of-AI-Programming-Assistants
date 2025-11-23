#include <vector>
using namespace std;

class Solution {
public:
    bool canDivideIntoSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        if (n % k != 0) return false;

        vector<int> last(k, -1);
        for (int i = 0; i < n; ++i) {
            int num = nums[i];
            bool placed = false;
            for (int j = 0; j < k; ++j) {
                if (last[j] < num) {
                    last[j] = num;
                    placed = true;
                    break;
                }
            }
            if (!placed) return false;
        }
        return true;
    }
};