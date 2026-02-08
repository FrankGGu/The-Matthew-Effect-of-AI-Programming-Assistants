#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string findTheString(vector<vector<int>>& lcp) {
        int n = lcp.size();
        string s(n, ' ');

        for (int i = 0; i < n; ++i) {
            if (s[i] == ' ') {
                s[i] = (char)('a' + i);
            }
            for (int j = i + 1; j < n; ++j) {
                if (lcp[i][j] > 0) {
                    if (s[j] == ' ') {
                        s[j] = s[i];
                    } else if (s[j] != s[i]) {
                        return "";
                    }
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int expected_lcp = 0;
                if (s[i] == s[j]) {
                    if (i > 0 && j > 0) {
                        expected_lcp = lcp[i - 1][j - 1] + 1;
                    } else {
                        expected_lcp = 1;
                    }
                }
                if (lcp[i][j] != expected_lcp)
                {
                  int len = 0;
                  if (s[i] == s[j])
                  {
                    int k = 0;
                    while (i + k < n && j + k < n && s[i+k] == s[j+k])
                    {
                      len++;
                      k++;
                    }
                  }
                  if (lcp[i][j] != len)
                    return "";
                }
            }
        }

        return s;
    }
};