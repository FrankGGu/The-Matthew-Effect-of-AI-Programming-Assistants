#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findUnsortedSubarray(vector<int>& nums) {
        int n = nums.size();
        vector<int> sortedNums = nums;
        sort(sortedNums.begin(), sortedNums.end());

        int start = n, end = -1;
        for (int i = 0; i < n; i++) {
            if (nums[i] != sortedNums[i]) {
                start = min(start, i);
                end = max(end, i);
            }
        }

        return (end - start >= 0) ? (end - start + 1) : 0;
    }
};