class Codec {
public:

    string serialize(TreeNode* root) {
        if (!root) return "null,";
        string res = to_string(root->val) + ",";
        res += serialize(root->left);
        res += serialize(root->right);
        return res;
    }

    TreeNode* deserialize(string data) {
        stringstream ss(data);
        string item;
        queue<string> q;
        while (getline(ss, item, ',')) {
            q.push(item);
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