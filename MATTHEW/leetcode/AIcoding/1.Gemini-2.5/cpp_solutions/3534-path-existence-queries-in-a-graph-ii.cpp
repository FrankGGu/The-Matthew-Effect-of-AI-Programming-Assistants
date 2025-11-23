#include <vector>
#include <numeric>
#include <algorithm>

class DSU {
public:
    std::vector<int> parent;
    std::vector<int> sz; // size of the component

    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0); // Initialize each node as its own parent
        sz.assign(n, 1); // Each component initially has size 1
    }

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]); // Path compression
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            // Union by size (or rank) to keep tree flat
            if (sz[root_i] < sz[root_j])
                std::swap(root_i, root_j); // Ensure root_i is the larger tree
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
        }
    }
};

struct Edge {
    int u, v, w;
};

struct Query {
    int u, v, w, original_index;
};

class Solution {
public:
    std::vector<bool> distanceLimitedPathsExist(int n, std::vector<std::vector<int>>& edgeList, std::vector<std::vector<int>>& queries) {

        // Prepare edges for sorting
        std::vector<Edge> sorted_edges;
        for (const auto& edge_vec : edgeList) {
            sorted_edges.push_back({edge_vec[0], edge_vec[1], edge_vec[2]});
        }
        // Sort edges in ascending order of weight
        std::sort(sorted_edges.begin(), sorted_edges.end(), [](const Edge& a, const Edge& b) {
            return a.w < b.w;
        });

        // Prepare queries for sorting
        std::vector<Query> sorted_queries;
        for (int i = 0; i < queries.size(); ++i) {
            sorted_queries.push_back({queries[i][0], queries[i][1], queries[i][2], i});
        }
        // Sort queries in ascending order of limit (w)
        std::sort(sorted_queries.begin(), sorted_queries.end(), [](const Query& a, const Query& b) {
            return a.w < b.w;
        });

        DSU dsu(n);
        std::vector<bool> results(queries.size());
        int edge_idx = 0; // Pointer for iterating through sorted_edges

        // Process queries in increasing order of their limits
        for (const auto& q : sorted_queries) {
            // Add all edges whose weight is strictly less than the current query's limit
            // These are the only edges that can be part of a valid path for this query
            while (edge_idx < sorted_edges.size() && sorted_edges[edge_idx].w < q.w) {
                dsu.unite(sorted_edges[edge_idx].u, sorted_edges[edge_idx].v);
                edge_idx++;
            }
            // After adding all relevant edges, check if u and v are connected
            results[q.original_index] = (dsu.find(q.u) == dsu.find(q.v));
        }

        return results;
    }
};