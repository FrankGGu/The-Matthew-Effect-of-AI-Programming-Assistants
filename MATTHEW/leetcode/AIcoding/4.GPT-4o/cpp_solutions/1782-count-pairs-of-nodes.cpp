class Solution {
public:
    int countPairs(TreeNode* root, int distance) {
        int count = 0;
        vector<int> depths;
        countPairsHelper(root, distance, depths, count);
        return count;
    }

    void countPairsHelper(TreeNode* node, int distance, vector<int>& depths, int& count) {
        if (!node) return;
        if (!node->left && !node->right) {
            depths.push_back(1);
            return;
        }

        vector<int> leftDepths, rightDepths;
        countPairsHelper(node->left, distance, leftDepths, count);
        countPairsHelper(node->right, distance, rightDepths, count);

        for (int l : leftDepths) {
            for (int r : rightDepths) {
                if (l + r <= distance) count++;
            }
        }

        for (int l : leftDepths) depths.push_back(l + 1);
        for (int r : rightDepths) depths.push_back(r + 1);
    }
};