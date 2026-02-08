class Solution {
public:
    TreeNode* createBinaryTree(vector<vector<int>>& descriptions) {
        unordered_map<int, TreeNode*> nodes;
        unordered_map<int, int> parent;
        for (auto& d : descriptions) {
            int p = d[0], c = d[1], isLeft = d[2];
            if (!nodes.count(p)) {
                nodes[p] = new TreeNode(p);
            }
            if (!nodes.count(c)) {
                nodes[c] = new TreeNode(c);
            }
            if (isLeft) {
                nodes[p]->left = nodes[c];
            } else {
                nodes[p]->right = nodes[c];
            }
            parent[c] = p;
        }
        for (auto& [val, node] : nodes) {
            if (!parent.count(val)) {
                return node;
            }
        }
        return nullptr;
    }
};