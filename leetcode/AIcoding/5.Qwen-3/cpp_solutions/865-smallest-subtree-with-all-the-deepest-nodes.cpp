#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    TreeNode* subtreeWithAllDeepest(TreeNode* root) {
        if (!root) return nullptr;

        unordered_map<TreeNode*, int> depthMap;
        queue<TreeNode*> q;
        q.push(root);
        int depth = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                depthMap[node] = depth;
                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }
            ++depth;
        }

        int maxDepth = depth - 1;
        unordered_map<TreeNode*, vector<TreeNode*>> parentMap;
        queue<TreeNode*> levelQ;
        levelQ.push(root);
        while (!levelQ.empty()) {
            int size = levelQ.size();
            for (int i = 0; i < size; ++i) {
                TreeNode* node = levelQ.front();
                levelQ.pop();
                if (node->left) {
                    parentMap[node->left].push_back(node);
                    levelQ.push(node->left);
                }
                if (node->right) {
                    parentMap[node->right].push_back(node);
                    levelQ.push(node->right);
                }
            }
        }

        vector<TreeNode*> deepestNodes;
        for (auto& pair : depthMap) {
            if (pair.second == maxDepth) {
                deepestNodes.push_back(pair.first);
            }
        }

        while (deepestNodes.size() > 1) {
            unordered_set<TreeNode*> nextLevel;
            for (TreeNode* node : deepestNodes) {
                for (TreeNode* parent : parentMap[node]) {
                    nextLevel.insert(parent);
                }
            }
            deepestNodes.clear();
            for (TreeNode* node : nextLevel) {
                deepestNodes.push_back(node);
            }
        }

        return deepestNodes[0];
    }
};