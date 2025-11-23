#include <queue>
#include <unordered_set>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class FindElements {
private:
    TreeNode* root;
    unordered_set<int> values;

public:
    FindElements(TreeNode* root) {
        this->root = root;
        if (root) {
            root->val = 0;
            queue<TreeNode*> q;
            q.push(root);
            values.insert(0);

            while (!q.empty()) {
                TreeNode* curr = q.front();
                q.pop();

                if (curr->left) {
                    curr->left->val = 2 * curr->val + 1;
                    values.insert(curr->left->val);
                    q.push(curr->left);
                }
                if (curr->right) {
                    curr->right->val = 2 * curr->val + 2;
                    values.insert(curr->right->val);
                    q.push(curr->right);
                }
            }
        }
    }

    bool find(int target) {
        return values.count(target) > 0;
    }
};