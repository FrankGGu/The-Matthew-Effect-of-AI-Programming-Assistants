#include <vector>

using namespace std;

class Solution {
public:
    vector<int> countSmaller(vector<int>& nums) {
        int n = nums.size();
        vector<int> counts(n, 0);
        vector<int> sortedNums;

        for (int i = n - 1; i >= 0; --i) {
            int left = 0, right = sortedNums.size();
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (sortedNums[mid] < nums[i]) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            counts[i] = left;
            sortedNums.insert(sortedNums.begin() + left, nums[i]);
        }

        return counts;
    }
};