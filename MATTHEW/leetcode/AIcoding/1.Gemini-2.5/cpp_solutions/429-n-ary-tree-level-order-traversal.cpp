class Solution {
public:
    vector<vector<int>> levelOrder(Node* root) {
        vector<vector<int>> result;
        if (!root) {
            return result;
        }

        std::queue<Node*> q;
        q.push(root);

        while (!q.empty()) {
            int level_size = q.size();
            vector<int> current_level_nodes;
            for (int i = 0; i < level_size; ++i) {
                Node* current_node = q.front();
                q.pop();
                current_level_nodes.push_back(current_node->val);

                for (Node* child : current_node->children) {
                    if (child) {
                        q.push(child);
                    }
                }
            }
            result.push_back(current_level_nodes);
        }

        return result;
    }
};