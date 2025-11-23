#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestSpecialPath(vector<int>& parent, string s) {
        int n = parent.size();
        vector<vector<int>> children(n);
        for (int i = 1; i < n; ++i) {
            children[parent[i]].push_back(i);
        }
        int max_len = 1;
        dfs(0, children, s, max_len);
        return max_len;
    }

private:
    int dfs(int node, vector<vector<int>>& children, string& s, int& max_len) {
        int max1 = 0, max2 = 0;
        for (int child : children[node]) {
            int len = dfs(child, children, s, max_len);
            if (s[child] != s[node]) {
                if (len > max1) {
                    max2 = max1;
                    max1 = len;
                } else if (len > max2) {
                    max2 = len;
                }
            }
        }
        max_len = max(max_len, max1 + max2 + 1);
        return max1 + 1;
    }
};