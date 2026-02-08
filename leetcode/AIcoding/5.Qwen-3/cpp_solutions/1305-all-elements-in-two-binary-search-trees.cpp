#include <iostream>
#include <vector>
#include <TreeNode.h>

using namespace std;

class Solution {
public:
    vector<int> getAllElements(TreeNode* root1, TreeNode* root2) {
        vector<int> result;
        vector<int> v1, v2;
        inorder(root1, v1);
        inorder(root2, v2);

        int i = 0, j = 0;
        while (i < v1.size() && j < v2.size()) {
            if (v1[i] < v2[j]) {
                result.push_back(v1[i]);
                ++i;
            } else {
                result.push_back(v2[j]);
                ++j;
            }
        }

        while (i < v1.size()) {
            result.push_back(v1[i]);
            ++i;
        }

        while (j < v2.size()) {
            result.push_back(v2[j]);
            ++j;
        }

        return result;
    }

private:
    void inorder(TreeNode* node, vector<int>& vec) {
        if (!node) return;
        inorder(node->left, vec);
        vec.push_back(node->val);
        inorder(node->right, vec);
    }
};