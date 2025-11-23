class Solution {
public:
    int minimumOperations(TreeNode* root) {
        if (!root) return 0;
        queue<TreeNode*> q;
        q.push(root);
        int res = 0;

        while (!q.empty()) {
            int size = q.size();
            vector<int> level;
            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                level.push_back(node->val);
                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }
            res += minSwaps(level);
        }
        return res;
    }

private:
    int minSwaps(vector<int>& arr) {
        int n = arr.size();
        vector<pair<int, int>> arrPos(n);
        for (int i = 0; i < n; ++i) {
            arrPos[i] = {arr[i], i};
        }
        sort(arrPos.begin(), arrPos.end());

        vector<bool> visited(n, false);
        int res = 0;

        for (int i = 0; i < n; ++i) {
            if (visited[i] || arrPos[i].second == i) continue;

            int cycle_size = 0;
            int j = i;
            while (!visited[j]) {
                visited[j] = true;
                j = arrPos[j].second;
                cycle_size++;
            }

            if (cycle_size > 0) {
                res += (cycle_size - 1);
            }
        }
        return res;
    }
};