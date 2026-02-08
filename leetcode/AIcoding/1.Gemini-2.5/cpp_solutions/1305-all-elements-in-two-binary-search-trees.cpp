#include <vector>

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
    void inorderTraversal(TreeNode* node, std::vector<int>& elements) {
        if (!node) {
            return;
        }
        inorderTraversal(node->left, elements);
        elements.push_back(node->val);
        inorderTraversal(node->right, elements);
    }

    std::vector<int> getAllElements(TreeNode* root1, TreeNode* root2) {
        std::vector<int> list1;
        std::vector<int> list2;

        inorderTraversal(root1, list1);
        inorderTraversal(root2, list2);

        std::vector<int> result;
        result.reserve(list1.size() + list2.size());

        int p1 = 0;
        int p2 = 0;
        int n1 = list1.size();
        int n2 = list2.size();

        while (p1 < n1 && p2 < n2) {
            if (list1[p1] <= list2[p2]) {
                result.push_back(list1[p1]);
                p1++;
            } else {
                result.push_back(list2[p2]);
                p2++;
            }
        }

        while (p1 < n1) {
            result.push_back(list1[p1]);
            p1++;
        }

        while (p2 < n2) {
            result.push_back(list2[p2]);
            p2++;
        }

        return result;
    }
};