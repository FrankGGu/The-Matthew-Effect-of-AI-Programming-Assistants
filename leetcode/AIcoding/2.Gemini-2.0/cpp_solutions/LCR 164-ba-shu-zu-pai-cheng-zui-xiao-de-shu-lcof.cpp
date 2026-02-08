#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int crackSafe(int n, int k) {
        if (n == 1 && k == 1) return 0;
        string ans = "";
        int total = pow(k, n);
        for (int i = 0; i < total; i++) {
            ans += '0';
        }
        string start = "";
        for (int i = 0; i < n - 1; i++) {
            start += '0';
        }
        unordered_set<string> visited;
        dfs(ans, start, n, k, visited);
        return stoi(ans);
    }

private:
    void dfs(string& ans, string current, int n, int k, unordered_set<string>& visited) {
        for (int i = k - 1; i >= 0; i--) {
            string next = current + to_string(i);
            string next_prefix = next.substr(next.length() - (n - 1), n - 1);
            if (visited.find(next) == visited.end()) {
                visited.insert(next);
                dfs(ans, next_prefix, n, k, visited);
                ans += to_string(i);
            }
        }
    }
};