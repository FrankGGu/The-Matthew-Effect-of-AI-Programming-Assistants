#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int findSubarrayWithBitwiseORClosestToK(vector<int>& arr, int k) {
        int n = arr.size();
        int ans = INT_MAX;
        int minDiff = INT_MAX;

        for (int i = 0; i < n; ++i) {
            int currentOr = 0;
            for (int j = i; j < n; ++j) {
                currentOr |= arr[j];
                int diff = abs(currentOr - k);
                if (diff < minDiff) {
                    minDiff = diff;
                    ans = currentOr;
                } else if (diff == minDiff) {
                    ans = min(ans, currentOr);
                }
            }
        }

        return ans;
    }
};