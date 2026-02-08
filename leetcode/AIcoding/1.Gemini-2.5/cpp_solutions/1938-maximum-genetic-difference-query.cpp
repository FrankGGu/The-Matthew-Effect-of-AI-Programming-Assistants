#include <vector>
#include <numeric>
#include <algorithm>

class TrieNode {
public:
    TrieNode* children[2];
    int count;

    TrieNode() : count(0) {
        children[0] = children[1] = nullptr;
    }
};

class Trie {
private:
    TrieNode* root;
    const int MAX_BITS = 17; // Values up to 10^5, which is less than 2^17

public:
    Trie() {
        root = new TrieNode();
    }

    void insert(int val) {
        TrieNode* curr = root;
        curr->count++;
        for (int i = MAX_BITS - 1; i >= 0; --i) {
            int bit = (val >> i) & 1;
            if (!curr->children[bit]) {
                curr->children[bit] = new TrieNode();
            }
            curr = curr->children[bit];
            curr->count++;
        }
    }

    void remove(int val) {
        TrieNode* curr = root;
        curr->count--;
        for (int i = MAX_BITS - 1; i >= 0; --i) {
            int bit = (val >> i) & 1;
            // Assuming val is present in the Trie.
            // No explicit deletion of nodes for simplicity in competitive programming.
            // Memory will be reclaimed at program termination.
            curr = curr->children[bit];
            curr->count--;
        }
    }

    int query(int val) {
        TrieNode* curr = root;
        int max_xor = 0;
        if (curr->count == 0) { // No elements in Trie
            return 0;
        }

        for (int i = MAX_BITS - 1; i >= 0; --i) {
            int bit = (val >> i) & 1;
            int desired_bit = 1 - bit; // Try to get the opposite bit to maximize XOR

            if (curr->children[desired_bit] && curr->children[desired_bit]->count > 0) {
                max_xor |= (1 << i);
                curr = curr->children[desired_bit];
            } else {
                // Must take the same bit
                // This path must exist if curr->count > 0 and desired_bit path is not available
                curr = curr->children[bit];
            }
        }
        return max_xor;
    }
};

class Solution {
private:
    std::vector<std::vector<int>> adj;
    std::vector<std::vector<std::pair<int, int>>> queries_at_node;
    std::vector<int> ans;
    std::vector<int> node_values;

    Trie trie;

    void dfs(int u, int p) {
        trie.insert(node_values[u]);

        for (auto& q : queries_at_node[u]) {
            int query_val = q.first;
            int query_idx = q.second;
            ans[query_idx] = trie.query(query_val);
        }

        for (int v : adj[u]) {
            if (v == p) continue;
            dfs(v, u);
        }

        trie.remove(node_values[u]);
    }

public:
    std::vector<int> maxGeneticDifference(std::vector<int>& parents, std::vector<std::vector<int>>& queries) {
        int n = parents.size();
        adj.resize(n);
        queries_at_node.resize(n);
        ans.resize(queries.size());
        node_values.resize(n);

        int root_node = -1;
        for (int i = 0; i < n; ++i) {
            node_values[i] = i; // Node i has value i, as per problem context
            if (parents[i] == -1) {
                root_node = i;
            } else {
                adj[parents[i]].push_back(i);
                adj[i].push_back(parents[i]); // Build undirected graph for DFS
            }
        }

        for (int i = 0; i < queries.size(); ++i) {
            int node = queries[i][0];
            int val = queries[i][1];
            queries_at_node[node].push_back({val, i});
        }

        dfs(root_node, -1);

        return ans;
    }
};