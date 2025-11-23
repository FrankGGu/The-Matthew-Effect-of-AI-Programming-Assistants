#include <vector>
#include <unordered_map>
#include <queue>
using namespace std;

class TreeNode {
public:
    int val;
    vector<TreeNode*> children;
    TreeNode(int x) : val(x) {}
};

class OperationTree {
public:
    unordered_map<int, TreeNode*> node_map;

    OperationTree(vector<vector<int>>& ops) {
        for (const auto& op : ops) {
            int parentVal = op[0];
            int childVal = op[1];
            if (node_map.find(parentVal) == node_map.end()) {
                node_map[parentVal] = new TreeNode(parentVal);
            }
            if (node_map.find(childVal) == node_map.end()) {
                node_map[childVal] = new TreeNode(childVal);
            }
            node_map[parentVal]->children.push_back(node_map[childVal]);
        }
    }

    vector<int> getTreeValues(int rootVal) {
        vector<int> result;
        if (node_map.find(rootVal) == node_map.end()) return result;
        queue<TreeNode*> q;
        q.push(node_map[rootVal]);
        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            result.push_back(node->val);
            for (auto child : node->children) {
                q.push(child);
            }
        }
        return result;
    }
};

class Solution {
public:
    vector<int> operationsOnTree(vector<vector<int>>& ops, int rootVal) {
        OperationTree tree(ops);
        return tree.getTreeValues(rootVal);
    }
};