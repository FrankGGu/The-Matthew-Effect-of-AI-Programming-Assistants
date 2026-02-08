#include <iostream>
#include <vector>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    bool isSubPath(ListNode* head, TreeNode* root) {
        if (!head) return true;
        if (!root) return false;

        return dfs(head, root) || isSubPath(head, root->left) || isSubPath(head, root->right);
    }

private:
    bool dfs(ListNode* head, TreeNode* root) {
        if (!head) return true;
        if (!root) return false;

        return head->val == root->val && dfs(head->next, root->left) || dfs(head->next, root->right);
    }
};