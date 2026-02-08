#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findCircleNum(vector<vector<int>>& isConnected) {
        int n = isConnected.size();
        vector<bool> visited(n, false);
        int provinces = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                provinces++;
                dfs(i, visited, isConnected);
            }
        }

        return provinces;
    }

private:
    void dfs(int node, vector<bool>& visited, vector<vector<int>>& isConnected) {
        visited[node] = true;
        for (int i = 0; i < isConnected.size(); ++i) {
            if (isConnected[node][i] && !visited[i]) {
                dfs(i, visited, isConnected);
            }
        }
    }
};