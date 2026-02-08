#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int findFirstAlmostEqualSubstring(string s, string t, int maxCost) {
        int n = s.size();
        int m = t.size();
        vector<int> cost(n, 0);

        for (int i = 0; i < n; ++i) {
            cost[i] = abs(s[i] - t[i]);
        }

        int left = 0;
        int currentCost = 0;
        int maxLen = 0;

        for (int right = 0; right < n; ++right) {
            currentCost += cost[right];

            while (currentCost > maxCost) {
                currentCost -= cost[left];
                left++;
            }

            maxLen = max(maxLen, right - left + 1);
        }

        return maxLen;
    }
};