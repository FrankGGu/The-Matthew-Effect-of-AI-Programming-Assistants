#include <vector>
#include <stack>

using namespace std;

class Node {
public:
    int val;
    vector<Node*> children;

    Node() {}

    Node(int _val) {
        val = _val;
    }

    Node(int _val, vector<Node*> _children) {
        val = _val;
        children = _children;
    }
};

class Solution {
public:
    vector<int> postorder(Node* root) {
        vector<int> result;
        if (!root) return result;

        stack<Node*> s;
        s.push(root);

        while (!s.empty()) {
            Node* node = s.top();
            if (node->children.empty()) {
                result.push_back(node->val);
                s.pop();
            } else {
                stack<Node*> childStack;
                for (Node* child : node->children) {
                    childStack.push(child);
                }
                node->children.clear();

                while (!childStack.empty()) {
                    Node* child = childStack.top();
                    childStack.pop();
                    s.push(child);
                }
            }
        }

        return result;
    }
};