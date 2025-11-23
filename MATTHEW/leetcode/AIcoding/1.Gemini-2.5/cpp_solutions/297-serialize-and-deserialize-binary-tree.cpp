#include <string>
#include <vector>
#include <sstream>
#include <queue>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Codec {
public:

    // Encodes a tree to a single string.
    std::string serialize(TreeNode* root) {
        if (!root) {
            return "#";
        }
        std::string s = std::to_string(root->val);
        s += "," + serialize(root->left);
        s += "," + serialize(root->right);
        return s;
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize(std::string data) {
        std::stringstream ss(data);
        std::string item;
        std::queue<std::string> q;
        while (std::getline(ss, item, ',')) {
            q.push(item);
        }
        return deserializeHelper(q);
    }

private:
    TreeNode* deserializeHelper(std::queue<std::string>& q) {
        std::string val = q.front();
        q.pop();

        if (val == "#") {
            return nullptr;
        }

        TreeNode* root = new TreeNode(std::stoi(val));
        root->left = deserializeHelper(q);
        root->right = deserializeHelper(q);
        return root;
    }
};