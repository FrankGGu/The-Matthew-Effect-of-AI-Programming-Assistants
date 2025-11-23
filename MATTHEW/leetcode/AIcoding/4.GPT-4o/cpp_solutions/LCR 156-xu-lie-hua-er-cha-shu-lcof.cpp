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
        queue<string> q;
        stringstream ss(data);
        string item;
        while (getline(ss, item, ',')) {
            q.push(item);
        }
        return buildTree(q);
    }

private:
    TreeNode* buildTree(queue<string>& q) {
        if (q.empty()) return nullptr;
        string val = q.front();
        q.pop();
        if (val == "#") return nullptr;
        TreeNode* root = new TreeNode(stoi(val));
        root->left = buildTree(q);
        root->right = buildTree(q);
        return root;
    }
};