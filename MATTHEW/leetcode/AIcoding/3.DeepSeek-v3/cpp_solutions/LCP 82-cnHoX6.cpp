#include <vector>
#include <unordered_map>
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
private:
    unordered_map<int, vector<TreeNode*>> memo;

public:
    vector<TreeNode*> allPossibleFBT(int n) {
        if (n % 2 == 0) {
            return {};
        }
        if (n == 1) {
            return {new TreeNode(0)};
        }
        if (memo.find(n) != memo.end()) {
            return memo[n];
        }

        vector<TreeNode*> result;
        for (int leftNodes = 1; leftNodes < n; leftNodes += 2) {
            int rightNodes = n - 1 - leftNodes;
            vector<TreeNode*> leftSubtrees = allPossibleFBT(leftNodes);
            vector<TreeNode*> rightSubtrees = allPossibleFBT(rightNodes);

            for (TreeNode* leftTree : leftSubtrees) {
                for (TreeNode* rightTree : rightSubtrees) {
                    TreeNode* root = new TreeNode(0);
                    root->left = leftTree;
                    root->right = rightTree;
                    result.push_back(root);
                }
            }
        }
        memo[n] = result;
        return result;
    }
};