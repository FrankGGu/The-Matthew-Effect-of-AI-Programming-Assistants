#include <vector>
#include <stack>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    vector<int> getAllElements(TreeNode* root1, TreeNode* root2) {
        vector<int> result;
        stack<TreeNode*> stack1, stack2;

        while (root1 || root2 || !stack1.empty() || !stack2.empty()) {
            while (root1) {
                stack1.push(root1);
                root1 = root1->left;
            }
            while (root2) {
                stack2.push(root2);
                root2 = root2->left;
            }

            if (stack1.empty() && stack2.empty()) break;

            if (stack2.empty() || (!stack1.empty() && stack1.top()->val <= stack2.top()->val)) {
                root1 = stack1.top();
                stack1.pop();
                result.push_back(root1->val);
                root1 = root1->right;
            } else {
                root2 = stack2.top();
                stack2.pop();
                result.push_back(root2->val);
                root2 = root2->right;
            }
        }

        return result;
    }
};