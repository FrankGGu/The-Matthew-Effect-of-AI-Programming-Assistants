#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumRemoval(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;

        vector<int> sorted = nums;
        sort(sorted.begin(), sorted.end());

        int maxLen = 0;
        int i = 0, j = 0;

        while (i < n && j < n) {
            if (nums[i] >= sorted[j]) {
                maxLen = max(maxLen, j - i + 1);
                j++;
            } else {
                i++;
            }
        }

        return n - maxLen;
    }
};