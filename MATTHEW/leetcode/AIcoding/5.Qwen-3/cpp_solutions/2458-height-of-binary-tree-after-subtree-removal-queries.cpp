#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    vector<int> treeQueries(TreeNode* root, vector<int>& queries) {
        unordered_map<TreeNode*, int> depthMap;
        unordered_map<TreeNode*, int> heightMap;

                function<void(TreeNode*, int)> dfsDepth = [&](TreeNode* node, int depth) {
            if (!node) return;
            depthMap[node] = depth;
            dfsDepth(node->left, depth + 1);
            dfsDepth(node->right, depth + 1);
        };

        function<int(TreeNode*)> dfsHeight = [&](TreeNode* node) {
            if (!node) return -1;
            int leftHeight = dfsHeight(node->left);
            int rightHeight = dfsHeight(node->right);
            heightMap[node] = 1 + max(leftHeight, rightHeight);
            return heightMap[node];
        };

        dfsDepth(root, 0);
        dfsHeight(root);

                unordered_map<TreeNode*, int> maxSiblingHeight;
        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            int size = q.size();
            vector<TreeNode*> levelNodes;
            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                levelNodes.push_back(node);
                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }

            for (int i = 0; i < levelNodes.size(); ++i) {
                TreeNode* node = levelNodes[i];
                int maxH = -1;
                for (int j = 0; j < levelNodes.size(); ++j) {
                    if (levelNodes[j] != node) {
                        maxH = max(maxH, heightMap[levelNodes[j]]);
                    }
                }
                maxSiblingHeight[node] = maxH;
            }
        }

        vector<int> result;
        for (int query : queries) {
            TreeNode* target = nullptr;
            queue<TreeNode*> q2;
            q2.push(root);
            while (!q2.empty()) {
                TreeNode* node = q2.front();
                q2.pop();
                if (node->val == query) {
                    target = node;
                    break;
                }
                if (node->left) q2.push(node->left);
                if (node->right) q2.push(node->right);
            }
            if (!target) {
                result.push_back(0);
                continue;
            }
            int depth = depthMap[target];
            int siblingHeight = maxSiblingHeight[target];
            int newHeight = siblingHeight;
            result.push_back(newHeight);
        }

        return result;
    }
};