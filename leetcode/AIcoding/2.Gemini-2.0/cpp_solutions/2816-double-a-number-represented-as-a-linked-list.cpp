class Solution {
public:
    ListNode* doubleIt(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* curr = head;
        int carry = 0;

        function<void(ListNode*)> doubleList = [&](ListNode* node) {
            if (!node) return;
            doubleList(node->next);
            int doubledVal = node->val * 2 + carry;
            node->val = doubledVal % 10;
            carry = doubledVal / 10;
        };

        doubleList(head);

        if (carry > 0) {
            dummy->val = carry;
            return dummy;
        } else {
            return head;
        }
    }
};