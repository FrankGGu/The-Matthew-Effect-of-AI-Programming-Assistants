#include <iostream>
#include <vector>
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
    vector<int> BFS(TreeNode* root) {
        vector<int> result;
        if (!root) return result;

        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            result.push_back(node->val);
            if (node->left) q.push(node->left);
            if (node->right) q.push(node->right);
        }

        return result;
    }

    vector<int> insertIntoCompleteBinaryTree(vector<int>& nums, int val) {
        TreeNode* root = buildTree(nums);
        insert(root, val);
        return BFS(root);
    }

private:
    TreeNode* buildTree(const vector<int>& nums) {
        if (nums.empty()) return nullptr;

        TreeNode* root = new TreeNode(nums[0]);
        queue<TreeNode*> q;
        q.push(root);

        int i = 1;
        while (!q.empty() && i < nums.size()) {
            TreeNode* node = q.front();
            q.pop();

            if (nums[i] != -1) {
                node->left = new TreeNode(nums[i]);
                q.push(node->left);
            }
            i++;

            if (i < nums.size() && nums[i] != -1) {
                node->right = new TreeNode(nums[i]);
                q.push(node->right);
            }
            i++;
        }

        return root;
    }

    void insert(TreeNode* root, int val) {
        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();

            if (!node->left) {
                node->left = new TreeNode(val);
                return;
            } else {
                q.push(node->left);
            }

            if (!node->right) {
                node->right = new TreeNode(val);
                return;
            } else {
                q.push(node->right);
            }
        }
    }
};