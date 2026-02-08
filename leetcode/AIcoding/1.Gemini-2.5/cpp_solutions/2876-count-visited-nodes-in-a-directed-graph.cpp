#include <vector>
#include <numeric>

class Solution {
private:
    std::vector<int> ans;
    std::vector<int> state; // 0: unvisited, 1: visiting (in current DFS path), 2: visited (processed)
    const std::vector<int>* edges_ptr; // Pointer to the problem's edges vector
    std::vector<int> path; // Stores nodes in the current DFS path
    std::vector<int> path_idx; // path_idx[node] = index in path vector, -1 if not in path

    void dfs(int u) {
        state[u] = 1; // Mark as visiting
        path.push_back(u);
        path_idx[u] = path.size() - 1;

        int v = (*edges_ptr)[u];

        if (state[v] == 1) { // Cycle detected: v is currently in the DFS path
            int cycle_start_idx = path_idx[v];
            int cycle_len = path.size() - cycle_start_idx;
            // All nodes from cycle_start_idx to path.size()-1 are part of the cycle
            for (int i = cycle_start_idx; i < path.size(); ++i) {
                ans[path[i]] = cycle_len;
                state[path[i]] = 2; // Mark all nodes in cycle as fully processed
            }
        } else if (state[v] == 0) { // Unvisited neighbor
            dfs(v); // Recurse. After this call returns, ans[v] and state[v] are finalized.
            // If u was part of a cycle found by dfs(v), ans[u] and state[u] would already be 2.
            // If not, calculate ans[u] based on ans[v].
            if (state[u] == 0) { // This means u was not part of a cycle found by dfs(v)
                ans[u] = 1 + ans[v];
                state[u] = 2;
            }
        } else { // state[v] == 2, already visited and processed
            // u must not be part of a cycle, as v is already processed and not in current path.
            ans[u] = 1 + ans[v];
            state[u] = 2;
        }

        // Clean up path for current node u.
        // u is always path.back() at this point.
        path.pop_back();
        path_idx[u] = -1; // Reset path_idx for u
    }

public:
    std::vector<int> countVisitedNodes(std::vector<int>& edges) {
        int n = edges.size();
        ans.resize(n);
        state.resize(n, 0); // Initialize all nodes as unvisited
        path_idx.resize(n, -1); // Initialize all nodes as not in any path
        edges_ptr = &edges; // Store pointer to edges vector

        for (int i = 0; i < n; ++i) {
            if (state[i] == 0) { // Only start DFS for unvisited nodes
                dfs(i);
            }
        }
        return ans;
    }
};