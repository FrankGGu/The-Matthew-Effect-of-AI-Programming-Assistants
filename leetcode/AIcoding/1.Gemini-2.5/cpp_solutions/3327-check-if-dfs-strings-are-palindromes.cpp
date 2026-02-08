#include <string>
#include <vector>
#include <algorithm> // For std::reverse

class Solution {
private:
    bool isPalindrome(const std::string& s) {
        std::string reversed_s = s;
        std::reverse(reversed_s.begin(), reversed_s.end());
        return s == reversed_s;
    }

    void dfs(int u, const std::vector<std::vector<int>>& adj, const std::string& nodeChars, std::string currentPath, bool& allArePalindromes) {
        if (!allArePalindromes) {
            return;
        }

        currentPath += nodeChars[u];

        if (adj[u].empty()) {
            if (!isPalindrome(currentPath)) {
                allArePalindromes = false;
            }
            return;
        }

        for (int v : adj[u]) {
            dfs(v, adj, nodeChars, currentPath, allArePalindromes);
            if (!allArePalindromes) {
                return;
            }
        }
    }

public:
    bool checkDFSStringsArePalindromes(int n, const std::vector<std::vector<int>>& adj, const std::string& nodeChars) {
        if (n == 0) {
            return true;
        }

        bool allArePalindromes = true;
        std::string currentPath = "";
        dfs(0, adj, nodeChars, currentPath, allArePalindromes);

        return allArePalindromes;
    }
};