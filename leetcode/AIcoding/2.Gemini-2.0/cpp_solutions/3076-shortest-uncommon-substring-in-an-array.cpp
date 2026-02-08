#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string shortestUncommonSubsequence(vector<string>& A, string B) {
        int n = A.size();
        int m = B.size();
        string ans = "";
        for (int len = 1; len <= m; ++len) {
            for (int i = 0; i <= m - len; ++i) {
                string sub = B.substr(i, len);
                bool found = false;
                for (int j = 0; j < n; ++j) {
                    if (A[j].find(sub) == string::npos) {
                        found = true;
                        break;
                    }
                }
                if (found) {
                    if (ans == "" || sub.length() < ans.length()) {
                        ans = sub;
                    }
                    return ans;
                }
            }
        }
        return ans;
    }
};