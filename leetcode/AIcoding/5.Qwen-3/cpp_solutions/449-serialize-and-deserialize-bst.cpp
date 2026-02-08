#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <queue>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
        string serialize(TreeNode* root) {
        ostringstream out;
        serializeHelper(root, out);
        return out.str();
    }

        TreeNode* deserialize(string data) {
        if (data.empty()) return nullptr;
        istringstream in(data);
        vector<string> nodes;
        string node;
        while (in >> node) {
            nodes.push_back(node);
        }
        return deserializeHelper(nodes, 0, nodes.size() - 1);
    }

private:
    void serializeHelper(TreeNode* root, ostringstream& out) {
        if (!root) {
            out << "# ";
            return;
        }
        out << root->val << " ";
        serializeHelper(root->left, out);
        serializeHelper(root->right, out);
    }

    TreeNode* deserializeHelper(vector<string>& nodes, int start, int end) {
        if (start > end) return nullptr;
        if (nodes[start] == "#") return nullptr;
        TreeNode* root = new TreeNode(stoi(nodes[start]));
        int i = start + 1;
        while (i <= end && !isLeaf(nodes[i])) {
            i++;
        }
        root->left = deserializeHelper(nodes, start + 1, i - 1);
        root->right = deserializeHelper(nodes, i, end);
        return root;
    }

    bool isLeaf(const string& s) {
        return s == "#";
    }
};