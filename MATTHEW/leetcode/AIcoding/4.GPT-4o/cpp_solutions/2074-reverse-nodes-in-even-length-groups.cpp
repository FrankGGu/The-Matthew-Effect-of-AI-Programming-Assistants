class Solution {
public:
    ListNode* reverseEvenLengthGroups(ListNode* head) {
        if (!head) return head;

        ListNode* dummy = new ListNode(0, head);
        ListNode* prevGroupEnd = dummy;
        ListNode* curr = head;
        int groupSize = 1;

        while (curr) {
            ListNode* groupStart = curr;
            int count = 0;
            while (curr && count < groupSize) {
                curr = curr->next;
                count++;
            }

            if (count % 2 == 0) {
                ListNode* prev = curr;
                ListNode* node = groupStart;
                for (int i = 0; i < count; i++) {
                    ListNode* nextNode = node->next;
                    node->next = prev;
                    prev = node;
                    node = nextNode;
                }
                prevGroupEnd->next = prev;
                groupStart->next = curr;
                prevGroupEnd = groupStart;
            } else {
                prevGroupEnd->next = groupStart;
                prevGroupEnd = groupStart;
            }

            groupSize++;
        }

        return dummy->next;
    }
};