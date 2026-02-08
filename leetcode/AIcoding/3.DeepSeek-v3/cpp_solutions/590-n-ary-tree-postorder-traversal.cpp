class Solution {
public:
    vector<int> postorder(Node* root) {
        vector<int> result;
        if (root == nullptr) {
            return result;
        }
        stack<Node*> stk;
        stk.push(root);
        while (!stk.empty()) {
            Node* node = stk.top();
            stk.pop();
            result.push_back(node->val);
            for (auto child : node->children) {
                stk.push(child);
            }
        }
        reverse(result.begin(), result.end());
        return result;
    }
};