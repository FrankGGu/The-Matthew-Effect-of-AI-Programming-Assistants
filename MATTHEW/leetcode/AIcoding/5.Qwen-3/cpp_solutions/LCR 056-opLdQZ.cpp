#include <iostream>
#include <vector>
#include <unordered_set>
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
    vector<int> inorderTraversal(TreeNode* root) {
        vector<int> result;
        stack<TreeNode*> stack;
        TreeNode* current = root;
        while (current != nullptr || !stack.empty()) {
            while (current != nullptr) {
                stack.push(current);
                current = current->left;
            }
            current = stack.top();
            stack.pop();
            result.push_back(current->val);
            current = current->right;
        }
        return result;
    }

    bool findTarget(TreeNode* root, int target) {
        vector<int> nums = inorderTraversal(root);
        unordered_set<int> seen;
        for (int num : nums) {
            if (seen.find(target - num) != seen.end()) {
                return true;
            }
            seen.insert(num);
        }
        return false;
    }
};