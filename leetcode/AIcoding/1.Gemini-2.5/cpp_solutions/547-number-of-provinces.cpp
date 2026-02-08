#include <vector>

class Solution {
public:
    void dfs(int city, int n, const std::vector<std::vector<int>>& isConnected, std::vector<bool>& visited) {
        visited[city] = true;
        for (int neighbor = 0; neighbor < n; ++neighbor) {
            if (isConnected[city][neighbor] == 1 && !visited[neighbor]) {
                dfs(neighbor, n, isConnected, visited);
            }
        }
    }

    int findCircleNum(std::vector<std::vector<int>>& isConnected) {
        int n = isConnected.size();
        std::vector<bool> visited(n, false);
        int provinces = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                provinces++;
                dfs(i, n, isConnected, visited);
            }
        }
        return provinces;
    }
};