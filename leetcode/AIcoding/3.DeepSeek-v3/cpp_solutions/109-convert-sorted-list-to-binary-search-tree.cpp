class Solution {
public:
    ListNode* globalHead;

    int getLength(ListNode* head) {
        int len = 0;
        while (head != nullptr) {
            len++;
            head = head->next;
        }
        return len;
    }

    TreeNode* build(int left, int right) {
        if (left > right) {
            return nullptr;
        }
        int mid = left + (right - left) / 2;
        TreeNode* leftTree = build(left, mid - 1);
        TreeNode* root = new TreeNode(globalHead->val);
        globalHead = globalHead->next;
        root->left = leftTree;
        root->right = build(mid + 1, right);
        return root;
    }

    TreeNode* sortedListToBST(ListNode* head) {
        globalHead = head;
        int n = getLength(head);
        return build(0, n - 1);
    }
};