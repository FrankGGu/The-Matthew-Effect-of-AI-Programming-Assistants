#include <string>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string crackSafe(int n, int k) {
        if (n == 1 && k == 1) return "0";
        string ans = "";
        int total = pow(k, n);
        unordered_set<string> visited;
        string start(n - 1, '0');

        function<void(string)> dfs = [&](string node) {
            for (int i = 0; i < k; ++i) {
                string next = node + to_string(i);
                if (visited.find(next) == visited.end()) {
                    visited.insert(next);
                    dfs(next.substr(1));
                    ans += to_string(i);
                }
            }
        };

        dfs(start);
        ans += string(n - 1, '0');
        return ans;
    }
};