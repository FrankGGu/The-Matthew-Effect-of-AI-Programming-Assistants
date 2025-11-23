#include <vector>
#include <numeric>

class Solution {
public:
    int findChampion(int n, std::vector<std::vector<int>>& edges) {
        std::vector<int> in_degree(n, 0);
        std::vector<int> out_degree(n, 0);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            out_degree[u]++;
            in_degree[v]++;
        }

        int champion_candidate = -1;
        int zero_in_degree_count = 0;

        for (int i = 0; i < n; ++i) {
            if (in_degree[i] == 0) {
                zero_in_degree_count++;
                champion_candidate = i;
            }
        }

        if (zero_in_degree_count == 1) {
            if (out_degree[champion_candidate] == n - 1) {
                return champion_candidate;
            }
        }

        return -1;
    }
};