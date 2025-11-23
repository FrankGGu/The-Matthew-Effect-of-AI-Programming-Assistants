#include <iostream>
#include <vector>

using namespace std;

class Solution {
private:
    int find(int x, vector<int>& parent) {
        if (parent[x] != x) {
            parent[x] = find(parent[x], parent);
        }
        return parent[x];
    }

    void unite(int x, int y, vector<int>& parent, vector<int>& rank) {
        int rootX = find(x, parent);
        int rootY = find(y, parent);
        if (rootX != rootY) {
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else {
                parent[rootX] = rootY;
                if (rank[rootX] == rank[rootY]) {
                    rank[rootY]++;
                }
            }
        }
    }

public:
    int makeConnected(int n, vector<vector<int>>& connections) {
        if (connections.size() < n - 1) {
            return -1;
        }

        vector<int> parent(n);
        vector<int> rank(n, 0);

        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        for (const auto& conn : connections) {
            unite(conn[0], conn[1], parent, rank);
        }

        int components = 0;
        for (int i = 0; i < n; ++i) {
            if (find(i, parent) == i) {
                components++;
            }
        }

        return components - 1;
    }
};