struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

class Solution {
public:
    ListNode* swapNodes(ListNode* head, int k) {
        ListNode *first = head, *second = head, *current = head;
        int length = 0;

        while (current) {
            length++;
            current = current->next;
        }

        for (int i = 1; i < k; i++) {
            first = first->next;
        }

        for (int i = 0; i < length - k; i++) {
            second = second->next;
        }

        std::swap(first->val, second->val);
        return head;
    }
};