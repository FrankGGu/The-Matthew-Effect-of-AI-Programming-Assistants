class Codec {
public:

    // Encodes a tree to a single string.
    string serialize(TreeNode* root) {
        if (!root) return "#";
        return to_string(root->val) + "," + serialize(root->left) + "," + serialize(root->right);
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize(string data) {
        int pos = 0;
        return helper(data, pos);
    }

    TreeNode* helper(string& data, int& pos) {
        if (pos >= data.size()) return nullptr;
        if (data[pos] == '#') {
            pos += 2;
            return nullptr;
        }
        int comma = data.find(',', pos);
        int val = stoi(data.substr(pos, comma - pos));
        TreeNode* node = new TreeNode(val);
        pos = comma + 1;
        node->left = helper(data, pos);
        node->right = helper(data, pos);
        return node;
    }
};