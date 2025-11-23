class Solution {
public:
    vector<int> countVisitedNodes(vector<int>& edges) {
        int n = edges.size();
        vector<int> visited(n, 0);
        vector<int> res(n, 0);

        for (int i = 0; i < n; ++i) {
            if (visited[i] == 0) {
                vector<int> path;
                int curr = i;
                while (true) {
                    if (visited[curr] == 1) {
                        int idx = find(path.begin(), path.end(), curr) - path.begin();
                        int cycle_len = path.size() - idx;
                        for (int j = idx; j < path.size(); ++j) {
                            res[path[j]] = cycle_len;
                        }
                        for (int j = 0; j < idx; ++j) {
                            res[path[j]] = cycle_len + idx - j;
                        }
                        break;
                    }
                    if (visited[curr] == 2) {
                        for (int j = 0; j < path.size(); ++j) {
                            res[path[j]] = res[curr] + path.size() - j;
                        }
                        break;
                    }
                    visited[curr] = 1;
                    path.push_back(curr);
                    curr = edges[curr];
                }
                for (int node : path) {
                    visited[node] = 2;
                }
            }
        }
        return res;
    }
};