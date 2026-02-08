#include <vector>
#include <queue>
#include <numeric>

class Solution {
public:
    bool sequenceReconstruction(std::vector<int>& nums, std::vector<std::vector<int>>& sequences) {
        int n = nums.size();

        if (sequences.empty()) {
            return false;
        }

        std::vector<std::vector<int>> adj(n + 1);
        std::vector<int> in_degree(n + 1, 0);

        for (const auto& seq : sequences) {
            if (seq.empty()) {
                continue;
            }
            for (size_t i = 0; i < seq.size() - 1; ++i) {
                int u = seq[i];
                int v = seq[i+1];

                adj[u].push_back(v);
                in_degree[v]++;
            }
        }

        std::queue<int> q;
        for (int i = 1; i <= n; ++i) {
            if (in_degree[i] == 0) {
                q.push(i);
            }
        }

        std::vector<int> reconstructed_seq;
        while (!q.empty()) {
            if (q.size() > 1) {
                return false;
            }

            int u = q.front();
            q.pop();
            reconstructed_seq.push_back(u);

            for (int v : adj[u]) {
                in_degree[v]--;
                if (in_degree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return reconstructed_seq.size() == n && reconstructed_seq == nums;
    }
};