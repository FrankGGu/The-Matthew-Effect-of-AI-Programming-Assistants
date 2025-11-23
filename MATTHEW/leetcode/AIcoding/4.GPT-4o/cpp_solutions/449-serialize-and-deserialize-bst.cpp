#include <string>
#include <sstream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Codec {
public:
    string serialize(TreeNode* root) {
        if (!root) return "";
        stringstream ss;
        serializeHelper(root, ss);
        return ss.str();
    }

    void serializeHelper(TreeNode* root, stringstream &ss) {
        if (!root) {
            ss << "# ";
            return;
        }
        ss << root->val << " ";
        serializeHelper(root->left, ss);
        serializeHelper(root->right, ss);
    }

    TreeNode* deserialize(string data) {
        if (data.empty()) return NULL;
        stringstream ss(data);
        return deserializeHelper(ss);
    }

    TreeNode* deserializeHelper(stringstream &ss) {
        string val;
        ss >> val;
        if (val == "#") return NULL;
        TreeNode* node = new TreeNode(stoi(val));
        node->left = deserializeHelper(ss);
        node->right = deserializeHelper(ss);
        return node;
    }
};