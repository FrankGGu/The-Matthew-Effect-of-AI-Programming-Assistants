class Solution {
public:
    ListNode* insert(ListNode* head, int insertVal) {
        ListNode* newNode = new ListNode(insertVal);
        if (!head) {
            newNode->next = newNode;
            return newNode;
        }

        ListNode* curr = head;
        ListNode* next = head->next;

        while (next != head) {
            if (curr->val <= insertVal && insertVal <= next->val) {
                break;
            }
            if (curr->val > next->val && (insertVal >= curr->val || insertVal <= next->val)) {
                break;
            }
            curr = next;
            next = next->next;
        }

        curr->next = newNode;
        newNode->next = next;

        return head;
    }
};