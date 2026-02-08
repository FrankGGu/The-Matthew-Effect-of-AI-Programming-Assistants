#include <algorithm>
#include <unordered_map>
#include <vector>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    int kthLargestPerfectSubtreeSize(TreeNode* root, int k) {
        unordered_map<int, int> freq;
        dfs(root, freq);
        vector<int> sizes;
        for (auto& p : freq) {
            sizes.push_back(p.first);
        }
        sort(sizes.begin(), sizes.end(), greater<int>());
        if (k > sizes.size()) return -1;
        return sizes[k-1];
    }

private:
    int dfs(TreeNode* node, unordered_map<int, int>& freq) {
        if (!node) return 0;
        int left = dfs(node->left, freq);
        int right = dfs(node->right, freq);
        if (left == -1 || right == -1 || left != right) {
            return -1;
        }
        int size = left + right + 1;
        freq[size]++;
        return size;
    }
};