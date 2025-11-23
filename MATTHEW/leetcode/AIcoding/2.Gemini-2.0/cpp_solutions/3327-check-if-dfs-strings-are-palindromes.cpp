#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool solve(int node, vector<vector<int>>& adj, vector<int>& path, string& s, vector<bool>& visited) {
        visited[node] = true;
        path.push_back(node);

        if (adj[node].empty()) {
            string current_string = "";
            for (int p : path) {
                current_string += s[p];
            }
            string reversed_string = current_string;
            reverse(reversed_string.begin(), reversed_string.end());

            path.pop_back();
            visited[node] = false;
            return current_string == reversed_string;
        }

        for (int neighbor : adj[node]) {
            if (!visited[neighbor]) {
                if (!solve(neighbor, adj, path, s, visited)) {
                    path.pop_back();
                    visited[node] = false;
                    return false;
                }
            }
        }
        path.pop_back();
        visited[node] = false;
        return true;
    }

    bool checkDFSStringsArePalindromes(int n, vector<vector<int>>& edges, string& s) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
        }

        vector<int> path;
        vector<bool> visited(n, false);

        for (int i = 0; i < n; ++i) {
            if (adj[i].empty()) {
                string current_string = "";
                current_string += s[i];
                string reversed_string = current_string;
                reverse(reversed_string.begin(), reversed_string.end());
                if (current_string != reversed_string) return false;
            }
        }

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                if (!solve(i, adj, path, s, visited)) {
                    return false;
                }
            }
        }

        return true;
    }
};