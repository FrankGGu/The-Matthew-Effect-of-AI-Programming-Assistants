#include <vector>
using namespace std;

struct Node {
    int val;
    vector<Node*> children;
    Node() {}
    Node(int _val) : val(_val) {}
    Node(int _val, vector<Node*> _children) : val(_val), children(_children) {}
};

class Solution {
public:
    vector<int> preorder(Node* root) {
        vector<int> result;
        if (!root) return result;
        result.push_back(root->val);
        for (auto child : root->children) {
            vector<int> childResult = preorder(child);
            result.insert(result.end(), childResult.begin(), childResult.end());
        }
        return result;
    }
};