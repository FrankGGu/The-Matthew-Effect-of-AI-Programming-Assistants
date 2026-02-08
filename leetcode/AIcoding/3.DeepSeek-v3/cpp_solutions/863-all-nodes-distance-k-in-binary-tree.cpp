class Solution {
public:
    vector<int> distanceK(TreeNode* root, TreeNode* target, int k) {
        unordered_map<TreeNode*, TreeNode*> parent_map;
        buildParentMap(root, nullptr, parent_map);

        queue<TreeNode*> q;
        unordered_set<TreeNode*> visited;
        q.push(target);
        visited.insert(target);

        int distance = 0;
        vector<int> result;

        while (!q.empty()) {
            int size = q.size();
            if (distance == k) {
                for (int i = 0; i < size; ++i) {
                    TreeNode* node = q.front();
                    q.pop();
                    result.push_back(node->val);
                }
                return result;
            }

            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();

                if (node->left && visited.find(node->left) == visited.end()) {
                    visited.insert(node->left);
                    q.push(node->left);
                }
                if (node->right && visited.find(node->right) == visited.end()) {
                    visited.insert(node->right);
                    q.push(node->right);
                }
                TreeNode* parent = parent_map[node];
                if (parent && visited.find(parent) == visited.end()) {
                    visited.insert(parent);
                    q.push(parent);
                }
            }
            distance++;
        }
        return result;
    }

private:
    void buildParentMap(TreeNode* node, TreeNode* parent, unordered_map<TreeNode*, TreeNode*>& parent_map) {
        if (!node) return;
        parent_map[node] = parent;
        buildParentMap(node->left, node, parent_map);
        buildParentMap(node->right, node, parent_map);
    }
};