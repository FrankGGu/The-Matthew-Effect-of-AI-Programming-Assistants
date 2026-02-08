#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> longestRepeating(string s, string queryCharacters, vector<int>& queryIndices) {
        int n = s.length();
        int m = queryCharacters.length();
        vector<int> ans(m);

        for (int i = 0; i < m; ++i) {
            char c = queryCharacters[i];
            int index = queryIndices[i];

            s[index] = c;

            int maxLen = 1;
            for (int j = 0; j < n; ++j) {
                int currLen = 1;
                for (int k = j + 1; k < n; ++k) {
                    if (s[k] == s[j]) {
                        currLen++;
                    } else {
                        break;
                    }
                }
                maxLen = max(maxLen, currLen);
            }
            ans[i] = maxLen;
        }

        return ans;
    }
};