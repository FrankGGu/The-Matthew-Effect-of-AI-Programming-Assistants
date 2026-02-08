#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    vector<int> result;
    unordered_map<int, int> freq;

    int dfs(TreeNode* node) {
        if (!node) return 0;
        int left = dfs(node->left);
        int right = dfs(node->right);
        int size = left + right + 1;
        freq[size]++;
        return size;
    }

    int kthLargestPerfectSubtreeSize(TreeNode* root, int k) {
        dfs(root);
        vector<pair<int, int>> sorted(freq.begin(), freq.end());
        sort(sorted.begin(), sorted.end(), greater<pair<int, int>>());
        for (auto& p : sorted) {
            if (k <= p.second) return p.first;
            k -= p.second;
        }
        return -1;
    }
};