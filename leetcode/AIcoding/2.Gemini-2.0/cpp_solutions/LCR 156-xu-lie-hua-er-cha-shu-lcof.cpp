class Codec {
public:

    // Encodes a tree to a single string.
    string serialize(TreeNode* root) {
        if (!root) return "null,";
        return to_string(root->val) + "," + serialize(root->left) + serialize(root->right);
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize(string data) {
        stringstream ss(data);
        string token;
        vector<string> nodes;
        while (getline(ss, token, ',')) {
            nodes.push_back(token);
        }
        int i = 0;
        return deserializeHelper(nodes, i);
    }

private:
    TreeNode* deserializeHelper(vector<string>& nodes, int& i) {
        if (nodes[i] == "null") {
            i++;
            return nullptr;
        }
        TreeNode* root = new TreeNode(stoi(nodes[i]));
        i++;
        root->left = deserializeHelper(nodes, i);
        root->right = deserializeHelper(nodes, i);
        return root;
    }
};