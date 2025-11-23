#include <string>
#include <vector>
#include <sstream>
#include <climits> // For INT_MIN, INT_MAX

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Codec {
public:
    // Encodes a tree to a single string.
    std::string serialize(TreeNode* root) {
        std::stringstream ss;
        serializeHelper(root, ss);
        return ss.str();
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize(std::string data) {
        if (data.empty()) {
            return nullptr;
        }

        std::stringstream ss(data);
        std::string item;
        std::vector<int> nodes_val;
        while (std::getline(ss, item, ' ')) {
            if (!item.empty()) { // Ensure no empty strings from multiple spaces or trailing space
                nodes_val.push_back(std::stoi(item));
            }
        }

        int idx = 0;
        return deserializeHelper(nodes_val, idx, INT_MIN, INT_MAX);
    }

private:
    void serializeHelper(TreeNode* node, std::stringstream& ss) {
        if (!node) {
            return;
        }
        ss << node->val << " ";
        serializeHelper(node->left, ss);
        serializeHelper(node->right, ss);
    }

    TreeNode* deserializeHelper(const std::vector<int>& nodes_val, int& idx, int lower_bound, int upper_bound) {
        if (idx >= nodes_val.size()) {
            return nullptr;
        }

        int val = nodes_val[idx];
        if (val < lower_bound || val > upper_bound) {
            return nullptr;
        }

        TreeNode* root = new TreeNode(val);
        idx++;

        root->left = deserializeHelper(nodes_val, idx, lower_bound, val);
        root->right = deserializeHelper(nodes_val, idx, val, upper_bound);

        return root;
    }
};