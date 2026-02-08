#include <string>
#include <queue>
#include <sstream>
#include <vector>

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
        if (!root) return "#";
        return to_string(root->val) + "," + serialize(root->left) + "," + serialize(root->right);
    }

    TreeNode* deserialize(string data) {
        stringstream ss(data);
        return buildTree(ss);
    }

private:
    TreeNode* buildTree(stringstream& ss) {
        string val;
        getline(ss, val, ',');
        if (val == "#") return nullptr;
        TreeNode* node = new TreeNode(stoi(val));
        node->left = buildTree(ss);
        node->right = buildTree(ss);
        return node;
    }
};