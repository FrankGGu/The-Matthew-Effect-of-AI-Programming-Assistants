class Solution {
public:
    int longestCycle(vector<int>& edges) {
        int n = edges.size();
        vector<bool> visited(n, false);
        vector<int> stack(n, -1);
        int longest = -1;

        function<int(int, int)> dfs = [&](int node, int depth) {
            if (stack[node] != -1) return stack[node];
            if (visited[node]) return -1;
            visited[node] = true;
            stack[node] = depth;

            int next = edges[node];
            if (next != -1) {
                int result = dfs(next, depth + 1);
                if (result != -1) {
                    if (stack[node] >= result) {
                        longest = max(longest, depth - result);
                    }
                }
            }

            stack[node] = -1;
            return visited[node] ? stack[node] : -1;
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                dfs(i, 0);
            }
        }

        return longest;
    }
};