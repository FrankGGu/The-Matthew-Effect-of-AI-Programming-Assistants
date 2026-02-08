#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int shortestSubarray(vector<int>& nums, int k) {
        int n = nums.size();
        int len = INT_MAX;
        for (int i = 0; i < n; i++) {
            int currentOr = 0;
            for (int j = i; j < n; j++) {
                currentOr |= nums[j];
                if (currentOr >= k) {
                    len = min(len, j - i + 1);
                    break;
                }
            }
        }
        return (len == INT_MAX) ? -1 : len;
    }
};