#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>
#include <queue>
#include <stack>
#include <string>
#include <cmath>
#include <climits>
#include <map>
#include <set>
#include <utility>
#include <functional>
#include <numeric>
#include <sstream>
#include <fstream>
#include <cstdlib>
#include <ctime>

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
    bool flipEquiv(TreeNode* root1, TreeNode* root2) {
        if (!root1 && !root2) return true;
        if (!root1 || !root2) return false;
        if (root1->val != root2->val) return false;

        bool noFlip = flipEquiv(root1->left, root2->left) && flipEquiv(root1->right, root2->right);
        bool withFlip = flipEquiv(root1->left, root2->right) && flipEquiv(root1->right, root2->left);

        return noFlip || withFlip;
    }
};