#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> movesToStamp(string stamp, string target) {
        int m = stamp.size();
        int n = target.size();
        vector<int> ans;
        vector<bool> visited(n, false);
        int stamped = 0;

        while (stamped < n) {
            bool changed = false;
            for (int i = 0; i <= n - m; ++i) {
                if (!visited[i]) {
                    int count = 0;
                    int wildcard = 0;
                    for (int j = 0; j < m; ++j) {
                        if (target[i + j] == stamp[j]) {
                            count++;
                        } else if (target[i + j] == '?') {
                            wildcard++;
                        } else {
                            break;
                        }
                    }
                    if (count + wildcard == m) {
                        ans.push_back(i);
                        changed = true;
                        visited[i] = true;
                        for (int j = 0; j < m; ++j) {
                            if (target[i + j] != '?') {
                                target[i + j] = '?';
                                stamped++;
                            }
                        }
                    }
                }
            }
            if (!changed) {
                return {};
            }
        }

        reverse(ans.begin(), ans.end());
        return ans;
    }
};