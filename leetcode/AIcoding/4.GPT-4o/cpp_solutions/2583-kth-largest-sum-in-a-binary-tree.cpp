#include <vector>
#include <queue>
#include <unordered_map>
using namespace std;

class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int kthLargestLevelSum(TreeNode* root, int k) {
        if (!root) return 0;
        unordered_map<int, long long> levelSum;
        queue<pair<TreeNode*, int>> q;
        q.push({root, 0});

        while (!q.empty()) {
            auto [node, level] = q.front();
            q.pop();
            levelSum[level] += node->val;
            if (node->left) q.push({node->left, level + 1});
            if (node->right) q.push({node->right, level + 1});
        }

        priority_queue<long long> pq;
        for (const auto& [level, sum] : levelSum) {
            pq.push(sum);
        }

        for (int i = 1; i < k; ++i) {
            pq.pop();
        }

        return pq.top();
    }
};