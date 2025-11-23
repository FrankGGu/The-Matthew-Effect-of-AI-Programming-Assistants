#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        int n = nums.size();
        vector<int> diff;
        for (int i = 0; i < n; ++i) {
            diff.push_back(nums[i]);
        }

        int operations = 0;
        while (true) {
            bool allZeros = true;
            for (int i = 0; i < n; ++i) {
                if (diff[i] != 0) {
                    allZeros = false;
                    break;
                }
            }
            if (allZeros) break;

            int minVal = INT_MAX;
            for (int i = 0; i < n; ++i) {
                if (diff[i] > 0) {
                    minVal = min(minVal, diff[i]);
                }
            }

            for (int i = 0; i < n; ++i) {
                if (diff[i] > 0) {
                    diff[i] -= minVal;
                }
            }
            operations++;
        }

        return operations;
    }
};