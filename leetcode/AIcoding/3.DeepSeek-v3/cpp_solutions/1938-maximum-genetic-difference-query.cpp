class TrieNode {
public:
    TrieNode* children[2];
    int count;
    TrieNode() {
        children[0] = children[1] = nullptr;
        count = 0;
    }
};

class Solution {
public:
    TrieNode* root;

    void insert(int num) {
        TrieNode* node = root;
        for (int i = 17; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (node->children[bit] == nullptr) {
                node->children[bit] = new TrieNode();
            }
            node = node->children[bit];
            node->count++;
        }
    }

    void remove(int num) {
        TrieNode* node = root;
        for (int i = 17; i >= 0; --i) {
            int bit = (num >> i) & 1;
            node = node->children[bit];
            node->count--;
        }
    }

    int query(int num) {
        TrieNode* node = root;
        int res = 0;
        for (int i = 17; i >= 0; --i) {
            int bit = (num >> i) & 1;
            int desiredBit = 1 - bit;
            if (node->children[desiredBit] != nullptr && node->children[desiredBit]->count > 0) {
                res |= (1 << i);
                node = node->children[desiredBit];
            } else {
                node = node->children[bit];
            }
        }
        return res;
    }

    void dfs(int u, unordered_map<int, vector<pair<int, int>>>& queries, vector<vector<int>>& tree, vector<int>& res) {
        insert(u);
        for (auto& [val, idx] : queries[u]) {
            res[idx] = query(val);
        }
        for (int v : tree[u]) {
            dfs(v, queries, tree, res);
        }
        remove(u);
    }

    vector<int> maxGeneticDifference(vector<int>& parents, vector<vector<int>>& queries) {
        root = new TrieNode();
        int n = parents.size();
        vector<vector<int>> tree(n);
        int rootNode = -1;
        for (int i = 0; i < n; ++i) {
            if (parents[i] == -1) {
                rootNode = i;
            } else {
                tree[parents[i]].push_back(i);
            }
        }

        unordered_map<int, vector<pair<int, int>>> queryMap;
        for (int i = 0; i < queries.size(); ++i) {
            queryMap[queries[i][0]].emplace_back(queries[i][1], i);
        }

        vector<int> res(queries.size());
        dfs(rootNode, queryMap, tree, res);
        return res;
    }
};