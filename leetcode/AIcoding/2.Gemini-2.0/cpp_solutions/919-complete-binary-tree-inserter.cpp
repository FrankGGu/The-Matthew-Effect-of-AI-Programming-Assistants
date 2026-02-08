class CBTInserter {
public:
    TreeNode* root;
    vector<TreeNode*> nodes;

    CBTInserter(TreeNode* root) {
        this->root = root;
        queue<TreeNode*> q;
        q.push(root);
        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            nodes.push_back(node);
            if (node->left) q.push(node->left);
            if (node->right) q.push(node->right);
        }
    }

    int insert(int v) {
        TreeNode* newNode = new TreeNode(v);
        nodes.push_back(newNode);
        int parentIndex = (nodes.size() - 1 - 1) / 2;
        TreeNode* parent = nodes[parentIndex];
        if (!parent->left) {
            parent->left = newNode;
        } else {
            parent->right = newNode;
        }
        return parent->val;
    }

    TreeNode* get_root() {
        return root;
    }
};