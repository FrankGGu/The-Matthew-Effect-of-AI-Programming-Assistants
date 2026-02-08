#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumRightShifts(vector<int>& nums) {
        int n = nums.size();
        vector<int> sortedNums = nums;
        sort(sortedNums.begin(), sortedNums.end());

        for (int shifts = 0; shifts < n; ++shifts) {
            bool sorted = true;
            for (int i = 0; i < n; ++i) {
                if (nums[i] != sortedNums[i]) {
                    sorted = false;
                    break;
                }
            }

            if (sorted) {
                return shifts;
            }

            vector<int> temp = nums;
            int last = temp[n - 1];
            for (int i = n - 1; i > 0; --i) {
                nums[i] = nums[i - 1];
            }
            nums[0] = last;
        }

        return -1;
    }
};