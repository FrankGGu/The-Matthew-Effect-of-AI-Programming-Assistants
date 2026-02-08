#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> postorder(Node* root) {
        vector<int> result;
        if (!root) return result;
        stack<Node*> s;
        s.push(root);
        while (!s.empty()) {
            Node* node = s.top();
            s.pop();
            result.push_back(node->val);
            for (Node* child : node->children) {
                s.push(child);
            }
        }
        reverse(result.begin(), result.end());
        return result;
    }
};