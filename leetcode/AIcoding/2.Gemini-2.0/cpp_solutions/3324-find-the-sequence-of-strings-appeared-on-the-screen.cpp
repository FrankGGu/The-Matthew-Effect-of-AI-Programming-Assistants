#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string crackSafe(int n, int k) {
        int total = pow(k, n);
        string ans = "";
        for (int i = 0; i < n; ++i) {
            ans += '0';
        }
        vector<bool> visited(total, false);
        visited[0] = true;
        int cnt = 1;

        function<bool(string)> dfs = [&](string s) {
            if (cnt == total) return true;
            string next_prefix = s.substr(1);
            for (int i = 0; i < k; ++i) {
                string next = next_prefix + to_string(i);
                int val = stoi(next);
                int num = 0;
                for(int j = 0; j < n; j++){
                    num = num * k + (next[j] - '0');
                }
                if (!visited[num]) {
                    visited[num] = true;
                    ans += to_string(i);
                    cnt++;
                    if (dfs(next)) return true;
                    visited[num] = false;
                    ans.pop_back();
                    cnt--;
                }
            }
            return false;
        };

        dfs(ans);
        return ans;
    }
};