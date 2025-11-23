#include <stack>
using namespace std;

class BSTIterator {
private:
    stack<TreeNode*> st;

public:
    BSTIterator(TreeNode* root) {
        while (root) {
            st.push(root);
            root = root->left;
        }
    }

    int next() {
        TreeNode* node = st.top();
        st.pop();
        int res = node->val;
        node = node->right;
        while (node) {
            st.push(node);
            node = node->left;
        }
        return res;
    }

    bool hasNext() {
        return !st.empty();
    }
};