class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode *parent;
    TreeNode(int x) : val(x), left(NULL), right(NULL), parent(NULL) {}
};

class TreeAncestor {
public:
    vector<vector<int>> dp;
    TreeAncestor(int n, vector<int>& parent) {
        dp = vector<vector<int>>(n, vector<int>(log2(n) + 1, -1));
        for (int i = 0; i < n; ++i) {
            dp[i][0] = parent[i];
        }
        for (int j = 1; (1 << j) <= n; ++j) {
            for (int i = 0; i < n; ++i) {
                if (dp[i][j - 1] != -1) {
                    dp[i][j] = dp[dp[i][j - 1]][j - 1];
                }
            }
        }
    }

    int getKthAncestor(int node, int k) {
        for (int j = 0; k > 0 && node != -1; ++j) {
            if (k & (1 << j)) {
                node = dp[node][j];
            }
        }
        return node;
    }
};