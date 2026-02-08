#include <vector>
#include <unordered_map>
#include <algorithm>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    vector<int> treeQueries(TreeNode* root, vector<int>& queries) {
        unordered_map<TreeNode*, int> heights;
        vector<int> max_height;
        calculateHeight(root, heights, max_height);

        vector<int> result;
        for (int query : queries) {
            int height = heights[root];
            if (root->val == query) {
                height = max_height[0];
            } else {
                height = max_height[1];
            }
            result.push_back(height);
        }
        return result;
    }

private:
    int calculateHeight(TreeNode* node, unordered_map<TreeNode*, int>& heights, vector<int>& max_height) {
        if (!node) return 0;
        int leftHeight = calculateHeight(node->left, heights, max_height);
        int rightHeight = calculateHeight(node->right, heights, max_height);
        heights[node] = max(leftHeight, rightHeight) + 1;
        if (leftHeight > rightHeight) {
            max_height.push_back(leftHeight);
        } else {
            max_height.push_back(rightHeight);
        }
        return heights[node];
    }
};