#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countPalindromicSubsequences(string s) {
        int n = s.length();
        vector<vector<int>> first(26);
        vector<vector<int>> last(26);

        for (int i = 0; i < 26; ++i) {
            first[i].push_back(n);
            last[i].push_back(-1);
        }

        for (int i = 0; i < n; ++i) {
            int c = s[i] - 'a';
            last[c][0] = i;
            if (first[c][0] == n) {
                first[c][0] = i;
            }
        }

        int count = 0;
        for (int i = 0; i < 26; ++i) {
            if (first[i][0] < last[i][0]) {
                for (int j = 0; j < 26; ++j) {
                    if (first[j][0] > first[i][0] && last[j][0] < last[i][0]) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
};