#include <string>
#include <vector>
#include <queue>
#include <sstream>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Codec {
public:
    std::string serialize(TreeNode* root) {
        std::ostringstream oss;
        serializeHelper(root, oss);
        return oss.str();
    }

    TreeNode* deserialize(std::string data) {
        std::queue<std::string> nodes;
        std::string token;
        std::istringstream iss(data);

        while (std::getline(iss, token, ',')) {
            nodes.push(token);
        }
        return deserializeHelper(nodes);
    }

private:
    void serializeHelper(TreeNode* root, std::ostringstream& oss) {
        if (root == nullptr) {
            oss << "#,";
            return;
        }
        oss << root->val << ",";
        serializeHelper(root->left, oss);
        serializeHelper(root->right, oss);
    }

    TreeNode* deserializeHelper(std::queue<std::string>& nodes) {
        std::string val = nodes.front();
        nodes.pop();

        if (val == "#") {
            return nullptr;
        }

        TreeNode* root = new TreeNode(std::stoi(val));
        root->left = deserializeHelper(nodes);
        root->right = deserializeHelper(nodes);
        return root;
    }
};