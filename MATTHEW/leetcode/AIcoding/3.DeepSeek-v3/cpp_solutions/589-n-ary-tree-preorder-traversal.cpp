class Solution {
public:
    vector<int> preorder(Node* root) {
        vector<int> result;
        if (!root) return result;
        stack<Node*> st;
        st.push(root);
        while (!st.empty()) {
            Node* node = st.top();
            st.pop();
            result.push_back(node->val);
            for (int i = node->children.size() - 1; i >= 0; --i) {
                st.push(node->children[i]);
            }
        }
        return result;
    }
};