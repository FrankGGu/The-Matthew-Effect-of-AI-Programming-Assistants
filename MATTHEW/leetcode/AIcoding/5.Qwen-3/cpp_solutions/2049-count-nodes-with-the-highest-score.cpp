#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countHighestScoreNodes(TreeNode* root) {
        int maxCount = 0;
        int result = 0;
        vector<int> subtreeSizes;
        getSubtreeSizes(root, subtreeSizes);
        int totalNodes = subtreeSizes.back();
        for (int i = 0; i < subtreeSizes.size(); ++i) {
            int leftSize = i > 0 ? subtreeSizes[i - 1] : 0;
            int rightSize = i + 1 < subtreeSizes.size() ? subtreeSizes[i + 1] : 0;
            int score = 1;
            if (leftSize > 0) score *= leftSize;
            if (rightSize > 0) score *= rightSize;
            if (totalNodes - subtreeSizes[i] > 0) score *= (totalNodes - subtreeSizes[i]);
            if (score > maxCount) {
                maxCount = score;
                result = 1;
            } else if (score == maxCount) {
                ++result;
            }
        }
        return result;
    }

private:
    int getSubtreeSizes(TreeNode* node, vector<int>& sizes) {
        if (!node) return 0;
        int left = getSubtreeSizes(node->left, sizes);
        int right = getSubtreeSizes(node->right, sizes);
        int size = left + right + 1;
        sizes.push_back(size);
        return size;
    }
};