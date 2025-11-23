#include <vector>
#include <string>
#include <stack>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

TreeNode* recoverFromPreorder(string S) {
    stack<TreeNode*> stk;
    int i = 0;
    while (i < S.size()) {
        int level = 0;
        while (i < S.size() && S[i] == '-') {
            level++;
            i++;
        }
        int val = 0;
        while (i < S.size() && isdigit(S[i])) {
            val = val * 10 + (S[i] - '0');
            i++;
        }
        TreeNode* node = new TreeNode(val);
        if (level == stk.size()) {
            if (!stk.empty()) {
                stk.top()->left = node;
            }
        } else {
            while (stk.size() > level) {
                stk.pop();
            }
            stk.top()->right = node;
        }
        stk.push(node);
    }
    while (stk.size() > 1) {
        stk.pop();
    }
    return stk.top();
}