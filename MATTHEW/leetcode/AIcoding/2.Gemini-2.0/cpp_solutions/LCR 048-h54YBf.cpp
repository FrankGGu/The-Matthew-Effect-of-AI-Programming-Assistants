class Codec {
public:

    // Encodes a tree to a single string.
    string serialize(TreeNode* root) {
        if (!root) return "null,";
        string res = to_string(root->val) + ",";
        res += serialize(root->left);
        res += serialize(root->right);
        return res;
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize(string data) {
        queue<string> q;
        string s;
        for (char c : data) {
            if (c == ',') {
                q.push(s);
                s = "";
            } else {
                s += c;
            }
        }
        return deserializeHelper(q);
    }

private:
    TreeNode* deserializeHelper(queue<string>& q) {
        string val = q.front();
        q.pop();
        if (val == "null") return nullptr;
        TreeNode* root = new TreeNode(stoi(val));
        root->left = deserializeHelper(q);
        root->right = deserializeHelper(q);
        return root;
    }
};