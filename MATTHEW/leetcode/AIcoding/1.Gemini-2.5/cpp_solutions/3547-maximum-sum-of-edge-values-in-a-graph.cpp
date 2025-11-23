#include <vector>
#include <algorithm>
#include <climits> // For LLONG_MIN

using namespace std;

vector<vector<int>> adj;
const vector<int>* node_values_ptr; // Use a pointer to avoid copying in DFS

pair<long long, long long> dfs(int u, int p) {
    long long even_sum = 0;
    long long odd_sum = LLONG_MIN; // Represents negative infinity

    for (int v : adj[u]) {
        if (v == p) {
            continue;
        }

        pair<long long, long long> child_res = dfs(v, u);
        long long child_even = child_res.first;
        long long child_odd = child_res.second;

        long long next_even_sum = LLONG_MIN;
        long long next_odd_sum = LLONG_MIN;

        long long current_u_val = (*node_values_ptr)[u];
        long long current_v_val = (*node_values_ptr)[v];
        long long edge_val = current_u_val + current_v_val;

        // Option 1: Don't select edge (u, v)
        // u's current parity remains, v's current parity remains.
        // Combine (even_sum, odd_sum) with (child_even, child_odd)
        if (even_sum != LLONG_MIN) {
            if (child_even != LLONG_MIN) {
                // u_even + v_even -> u_even
                next_even_sum = max(next_even_sum, even_sum + child_even);
            }
            if (child_odd != LLONG_MIN) {
                // u_even + v_odd -> u_odd
                next_odd_sum = max(next_odd_sum, even_sum + child_odd);
            }
        }
        if (odd_sum != LLONG_MIN) {
            if (child_even != LLONG_MIN) {
                // u_odd + v_even -> u_odd
                next_odd_sum = max(next_odd_sum, odd_sum + child_even);
            }
            if (child_odd != LLONG_MIN) {
                // u_odd + v_odd -> u_even
                next_even_sum = max(next_even_sum, odd_sum + child_odd);
            }
        }

        // Option 2: Select edge (u, v)
        // u's current parity flips, v's current parity flips.
        // Add values[u] + values[v] to the score.
        // Combine (even_sum, odd_sum) with (child_even, child_odd)
        if (even_sum != LLONG_MIN) {
            if (child_even != LLONG_MIN) { 
                // u_even + v_even + edge_val -> u_odd (u flips), v_odd (v flips)
                next_odd_sum = max(next_odd_sum, even_sum + child_even + edge_val);
            }
            if (child_odd != LLONG_MIN) { 
                // u_even + v_odd + edge_val -> u_odd (u flips), v_even (v flips)
                next_even_sum = max(next_even_sum, even_sum + child_odd + edge_val);
            }
        }
        if (odd_sum != LLONG_MIN) {
            if (child_even != LLONG_MIN) { 
                // u_odd + v_even + edge_val -> u_even (u flips), v_odd (v flips)
                next_even_sum = max(next_even_sum, odd_sum + child_even + edge_val);
            }
            if (child_odd != LLONG_MIN) { 
                // u_odd + v_odd + edge_val -> u_even (u flips), v_even (v flips)
                next_odd_sum = max(next_odd_sum, odd_sum + child_odd + edge_val);
            }
        }

        even_sum = next_even_sum;
        odd_sum = next_odd_sum;
    }

    return {even_sum, odd_sum};
}

class Solution {
public:
    long long maximumEdgeValue(int n, vector<vector<int>>& edges, vector<int>& values) {
        adj.assign(n, vector<int>());
        node_values_ptr = &values; // Set the pointer

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        // The problem asks for every node to have an even degree.
        // The DFS function calculates the maximum score for a subtree such that
        // the root of the subtree (u) has an even/odd degree *from its children*.
        // The crucial part is that the decision for edge (u,p) (where p is parent)
        // is made by p. If p chooses to connect to u, it flips u's parity.
        // The final result of dfs(0, -1).first ensures that node 0 has an even degree
        // from its children. Since node 0 has no parent, this means its global degree is even.
        // For any other node v, its parent u will have made a choice for (u,v)
        // such that v's global degree ends up even. This is implicitly handled by the DP transitions.
        // For example, if u wants to maintain even degree and v returns child_odd, u can select (u,v)
        // to make v's global degree even (odd from children + 1 from (u,v)).
        // This is a standard solution pattern for "Maximum Weight Even Subgraph" on a tree.
        pair<long long, long long> result = dfs(0, -1);
        return result.first; // We need the root to have an even degree globally.
    }
};