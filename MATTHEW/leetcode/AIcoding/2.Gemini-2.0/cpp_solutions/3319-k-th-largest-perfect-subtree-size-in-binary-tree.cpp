#include <vector>
#include <algorithm>

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
    vector<int> sizes;
    function<int(TreeNode*)> dfs = [&](TreeNode* node) {
      if (!node) return 0;
      int leftSize = dfs(node->left);
      int rightSize = dfs(node->right);
      if (leftSize == rightSize && ((leftSize == 0) || ((leftSize & (leftSize - 1)) == 0))) {
        sizes.push_back(leftSize * 2 + 1);
        return leftSize * 2 + 1;
      }
      return 0;
    };

    dfs(root);
    if (sizes.size() < k) return -1;
    sort(sizes.begin(), sizes.end(), greater<int>());
    return sizes[k - 1];
  }
};