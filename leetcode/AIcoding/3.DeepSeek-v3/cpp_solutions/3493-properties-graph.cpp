class Solution {
public:
    vector<int> countVisitedNodes(vector<int>& edges) {
        int n = edges.size();
        vector<int> visited(n, -1);
        vector<int> res(n, 0);

        for (int i = 0; i < n; ++i) {
            if (visited[i] == -1) {
                vector<int> path;
                int curr = i;
                while (curr != -1 && visited[curr] == -1) {
                    visited[curr] = i;
                    path.push_back(curr);
                    curr = edges[curr];
                }
                if (curr != -1 && visited[curr] == i) {
                    int cycle_start = 0;
                    while (path[cycle_start] != curr) {
                        cycle_start++;
                    }
                    int cycle_len = path.size() - cycle_start;
                    for (int j = cycle_start; j < path.size(); ++j) {
                        res[path[j]] = cycle_len;
                    }
                    for (int j = 0; j < cycle_start; ++j) {
                        res[path[j]] = cycle_len + (cycle_start - j);
                    }
                } else {
                    for (int j = 0; j < path.size(); ++j) {
                        int node = path[j];
                        if (res[node] == 0) {
                            res[node] = path.size() - j;
                        }
                    }
                }
            }
        }
        return res;
    }
};