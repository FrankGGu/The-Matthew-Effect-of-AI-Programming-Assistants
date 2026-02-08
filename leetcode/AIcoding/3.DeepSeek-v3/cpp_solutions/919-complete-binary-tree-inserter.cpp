class CBTInserter {
private:
    TreeNode* root;
    queue<TreeNode*> q;
public:
    CBTInserter(TreeNode* root) {
        this->root = root;
        q.push(root);
        while (!q.empty()) {
            TreeNode* node = q.front();
            if (node->left && node->right) {
                q.pop();
                q.push(node->left);
                q.push(node->right);
            } else {
                if (node->left) q.push(node->left);
                break;
            }
        }
    }

    int insert(int val) {
        TreeNode* node = q.front();
        TreeNode* newNode = new TreeNode(val);
        if (!node->left) {
            node->left = newNode;
        } else {
            node->right = newNode;
            q.pop();
            q.push(node->left);
            q.push(node->right);
        }
        return node->val;
    }

    TreeNode* get_root() {
        return root;
    }
};