#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int missingInteger(vector<int>& nums) {
        int n = nums.size();
        int sum = nums[0];
        int i = 1;
        while (i < n && nums[i] == nums[i - 1] + 1) {
            sum += nums[i];
            i++;
        }

        int k = sum;
        while (true) {
            bool found = false;
            for (int j = 0; j < n; j++) {
                if (nums[j] == k) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                return k;
            }
            k++;
        }
    }
};