class UnionFind {
private:
    vector<int> parent;
    vector<int> rank;
public:
    UnionFind(int size) {
        parent.resize(size);
        rank.resize(size, 0);
        for (int i = 0; i < size; ++i) {
            parent[i] = i;
        }
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSet(int x, int y) {
        int xRoot = find(x);
        int yRoot = find(y);
        if (xRoot == yRoot) return;
        if (rank[xRoot] < rank[yRoot]) {
            parent[xRoot] = yRoot;
        } else if (rank[xRoot] > rank[yRoot]) {
            parent[yRoot] = xRoot;
        } else {
            parent[yRoot] = xRoot;
            rank[xRoot]++;
        }
    }
};

class Solution {
public:
    int numberOfGoodPaths(vector<int>& vals, vector<vector<int>>& edges) {
        int n = vals.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        map<int, vector<int>> valueToNodes;
        for (int i = 0; i < n; ++i) {
            valueToNodes[vals[i]].push_back(i);
        }

        UnionFind uf(n);
        int result = 0;

        for (auto& [val, nodes] : valueToNodes) {
            for (int node : nodes) {
                for (int neighbor : adj[node]) {
                    if (vals[neighbor] <= val) {
                        uf.unionSet(node, neighbor);
                    }
                }
            }

            unordered_map<int, int> groupCount;
            for (int node : nodes) {
                groupCount[uf.find(node)]++;
            }

            for (auto& [group, count] : groupCount) {
                result += count * (count + 1) / 2;
            }
        }

        return result;
    }
};