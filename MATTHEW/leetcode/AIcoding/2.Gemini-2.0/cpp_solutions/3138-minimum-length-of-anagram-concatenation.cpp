#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minAnagramLength(string s) {
        int n = s.length();
        vector<int> dp(n + 1, n + 1);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= i; ++j) {
                string sub = s.substr(i - j, j);
                string sortedSub = sub;
                sort(sortedSub.begin(), sortedSub.end());

                bool found = false;
                for (int k = j; k <= i; ++k) {
                    string possibleAnagram = s.substr(i - k, k);
                    string sortedPossibleAnagram = possibleAnagram;
                    sort(sortedPossibleAnagram.begin(), sortedPossibleAnagram.end());

                    if (sortedSub == sortedPossibleAnagram) {
                        dp[i] = min(dp[i], dp[i - k] + 1);
                        found = true;
                    }
                }
                if(!found && j == i){
                    dp[i] = min(dp[i], i);
                }
            }
        }

        return dp[n];
    }
};