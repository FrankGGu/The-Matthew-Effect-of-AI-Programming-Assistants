class Solution {
private:
    ListNode* current_list_node;

    TreeNode* buildTree(int left, int right) {
        if (left > right) {
            return nullptr;
        }

        int mid = left + (right - left) / 2;

        TreeNode* left_child = buildTree(left, mid - 1);

        TreeNode* root = new TreeNode(current_list_node->val);
        root->left = left_child;

        current_list_node = current_list_node->next;

        TreeNode* right_child = buildTree(mid + 1, right);
        root->right = right_child;

        return root;
    }

public:
    TreeNode* sortedListToBST(ListNode* head) {
        if (!head) {
            return nullptr;
        }

        current_list_node = head;

        int n = 0;
        ListNode* temp = head;
        while (temp) {
            n++;
            temp = temp->next;
        }

        return buildTree(0, n - 1);
    }
};