class Solution {
public:
    vector<vector<int>> levelOrder(Node* root) {
        vector<vector<int>> result;
        if (!root) return result;

        queue<Node*> q;
        q.push(root);

        while (!q.empty()) {
            int levelSize = q.size();
            vector<int> currentLevel;

            for (int i = 0; i < levelSize; ++i) {
                Node* node = q.front();
                q.pop();
                currentLevel.push_back(node->val);

                for (auto child : node->children) {
                    if (child) q.push(child);
                }
            }

            result.push_back(currentLevel);
        }

        return result;
    }
};