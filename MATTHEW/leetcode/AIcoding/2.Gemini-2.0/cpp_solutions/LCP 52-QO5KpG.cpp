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
    vector<int> nums;

    TreeNode* getTreeNode(vector<int>& arr, int l, int r) {
        if (l > r) return nullptr;
        int m = (l + r) / 2;
        TreeNode* root = new TreeNode(arr[m]);
        root->left = getTreeNode(arr, l, m - 1);
        root->right = getTreeNode(arr, m + 1, r);
        return root;
    }

    vector<vector<int>> colorTheGrid(int m, int n) {
        vector<int> arr(m);
        for (int i = 0; i < m; ++i) arr[i] = i + 1;

        TreeNode* root = getTreeNode(arr, 0, m - 1);
        return {{}};
    }

    vector<vector<int>> colorTheGrid(int m, int n, TreeNode* root) {
        vector<vector<int>> result;
        return result;
    }

    int getCount(int m, int n) {
        vector<vector<int>> grid(m, vector<int>(n));
        int count = 0;

        function<void(int, int)> solve = [&](int row, int col) {
            if (row == m) {
                count++;
                return;
            }

            for (int color = 1; color <= 5; ++color) {
                bool valid = true;
                if (row > 0 && grid[row - 1][col] == color) {
                    valid = false;
                }
                if (col > 0 && grid[row][col - 1] == color) {
                    valid = false;
                }

                if (valid) {
                    grid[row][col] = color;
                    if (col == n - 1) {
                        solve(row + 1, 0);
                    } else {
                        solve(row, col + 1);
                    }
                }
            }
        };

        solve(0, 0);
        return count;
    }
};