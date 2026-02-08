class Solution {
public:
    vector<TreeNode*> findDuplicateSubtrees(TreeNode* root) {
        vector<TreeNode*> res;
        unordered_map<string, int> subtreeCount;
        unordered_map<string, TreeNode*> subtreeNode;

        function<string(TreeNode*)> traverse = [&](TreeNode* node) {
            if (!node) return "#";
            string left = traverse(node->left);
            string right = traverse(node->right);
            string subtree = to_string(node->val) + "," + left + "," + right;

            subtreeCount[subtree]++;
            if (subtreeCount[subtree] == 2) {
                res.push_back(node);
            }
            return subtree;
        };

        traverse(root);
        return res;
    }
};