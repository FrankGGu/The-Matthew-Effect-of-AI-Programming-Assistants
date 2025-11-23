class Solution {
public:
    void getLeafSequence(TreeNode* node, std::vector<int>& leaves) {
        if (!node) {
            return;
        }
        if (!node->left && !node->right) {
            leaves.push_back(node->val);
            return;
        }
        getLeafSequence(node->left, leaves);
        getLeafSequence(node->right, leaves);
    }

    bool isLeafSimilar(TreeNode* root1, TreeNode* root2) {
        std::vector<int> leaves1;
        std::vector<int> leaves2;

        getLeafSequence(root1, leaves1);
        getLeafSequence(root2, leaves2);

        return leaves1 == leaves2;
    }
};