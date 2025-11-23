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

    // Encodes a tree to a single string.
    std::string serialize(TreeNode* root) {
        if (!root) {
            return "null";
        }

        std::string result = "";
        std::queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            TreeNode* current = q.front();
            q.pop();

            if (current == nullptr) {
                result += "null,";
            } else {
                result += std::to_string(current->val) + ",";
                q.push(current->left);
                q.push(current->right);
            }
        }

        // Remove trailing commas that might be left from the last few nulls
        // Or remove the last comma if it's not a null
        // A simpler way is to build a vector and then join, but this works too.
        // Let's refine the loop to avoid excessive trailing nulls and commas
        // The current BFS approach serializes all levels, including all null children of the last non-null node.
        // This is fine for deserialization as long as the format is consistent.
        // The current logic will produce something like "1,2,3,null,null,4,5,null,null,null,null,"
        // which is perfectly deserializable. No need to trim.
        // However, if the problem implies minimal serialization, we might need to trim.
        // For standard LeetCode problems, this full BFS serialization is acceptable.

        // Trim trailing comma if any
        if (!result.empty() && result.back() == ',') {
            result.pop_back();
        }

        return result;
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize(std::string data) {
        if (data == "null") {
            return nullptr;
        }

        std::stringstream ss(data);
        std::string item;
        std::vector<std::string> nodes_str;

        while (std::getline(ss, item, ',')) {
            nodes_str.push_back(item);
        }

        if (nodes_str.empty()) {
            return nullptr;
        }

        TreeNode* root = new TreeNode(std::stoi(nodes_str[0]));
        std::queue<TreeNode*> q;
        q.push(root);

        int i = 1;
        while (!q.empty() && i < nodes_str.size()) {
            TreeNode* current = q.front();
            q.pop();

            // Left child
            if (i < nodes_str.size() && nodes_str[i] != "null") {
                current->left = new TreeNode(std::stoi(nodes_str[i]));
                q.push(current->left);
            }
            i++;

            // Right child
            if (i < nodes_str.size() && nodes_str[i] != "null") {
                current->right = new TreeNode(std::stoi(nodes_str[i]));
                q.push(current->right);
            }
            i++;
        }
        return root;
    }
};