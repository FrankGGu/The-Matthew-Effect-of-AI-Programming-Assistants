class UnionFind {
public:
    vector<int> parent, size;
    UnionFind(int n) {
        parent.resize(n);
        size.resize(n, 1);
        for (int i = 0; i < n; i++) parent[i] = i;
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSets(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (size[rootX] < size[rootY]) {
                swap(rootX, rootY);
            }
            parent[rootY] = rootX;
            size[rootX] += size[rootY];
        }
    }
};

class Solution {
public:
    vector<int> shortestDistance(int n, vector<vector<int>>& roads, vector<vector<int>>& queries) {
        UnionFind uf(n);
        vector<vector<int>> graph(n);

        for (auto& road : roads) {
            graph[road[0]].push_back(road[1]);
            graph[road[1]].push_back(road[0]);
            uf.unionSets(road[0], road[1]);
        }

        vector<int> result;
        for (auto& query : queries) {
            if (uf.find(query[0]) != uf.find(query[1])) {
                result.push_back(-1);
            } else {
                result.push_back(1);
            }
        }

        return result;
    }
};