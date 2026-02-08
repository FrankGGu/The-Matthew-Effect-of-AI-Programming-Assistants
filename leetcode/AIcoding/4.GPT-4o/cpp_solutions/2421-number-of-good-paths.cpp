class Solution {
public:
    int numberOfGoodPaths(vector<int>& vals, vector<vector<int>>& edges) {
        int n = vals.size();
        unordered_map<int, vector<int>> graph;
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<vector<int>> components(n);
        vector<int> parent(n, -1);
        vector<int> size(n, 1);

        function<int(int)> find = [&](int x) {
            if (parent[x] == -1)
                return x;
            return parent[x] = find(parent[x]);
        };

        for (int i = 0; i < n; ++i) {
            for (int j : graph[i]) {
                int root1 = find(i);
                int root2 = find(j);
                if (root1 != root2) {
                    if (vals[root1] < vals[root2]) {
                        parent[root1] = root2;
                        size[root2] += size[root1];
                    } else if (vals[root1] > vals[root2]) {
                        parent[root2] = root1;
                        size[root1] += size[root2];
                    } else {
                        parent[root1] = root2;
                        size[root2] += size[root1];
                    }
                }
            }
        }

        unordered_map<int, int> count;
        int result = 0;
        for (int i = 0; i < n; ++i) {
            int root = find(i);
            if (vals[root] == vals[i]) {
                result += ++count[root];
            }
        }

        return result + n;
    }
};