#include <vector>
#include <queue>
#include <map>

class Solution {
public:
    int minJumps(std::vector<int>& arr) {
        int n = arr.size();
        if (n <= 1) {
            return 0;
        }

        std::map<int, std::vector<int>> graph_val;
        for (int i = 0; i < n; ++i) {
            graph_val[arr[i]].push_back(i);
        }

        std::queue<int> q;
        q.push(0);
        std::vector<bool> visited(n, false);
        visited[0] = true;

        int steps = 0;

        while (!q.empty()) {
            int level_size = q.size();
            for (int i = 0; i < level_size; ++i) {
                int curr_idx = q.front();
                q.pop();

                if (curr_idx == n - 1) {
                    return steps;
                }

                // Option 1: Jump to curr_idx + 1
                if (curr_idx + 1 < n && !visited[curr_idx + 1]) {
                    q.push(curr_idx + 1);
                    visited[curr_idx + 1] = true;
                }

                // Option 2: Jump to curr_idx - 1
                if (curr_idx - 1 >= 0 && !visited[curr_idx - 1]) {
                    q.push(curr_idx - 1);
                    visited[curr_idx - 1] = true;
                }

                // Option 3: Jump to other indices with the same value
                // Optimization: Process all same-value neighbors and then clear the list for this value
                // This prevents redundant processing and cycles, crucial for performance.
                if (graph_val.count(arr[curr_idx])) {
                    for (int next_idx : graph_val[arr[curr_idx]]) {
                        if (!visited[next_idx]) {
                            q.push(next_idx);
                            visited[next_idx] = true;
                        }
                    }
                    graph_val.erase(arr[curr_idx]); 
                }
            }
            steps++;
        }

        return -1; // Should not be reached if a path exists (which it always does for n >= 1)
    }
};