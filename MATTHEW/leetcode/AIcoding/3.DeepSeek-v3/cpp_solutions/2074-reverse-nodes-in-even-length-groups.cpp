class Solution {
public:
    ListNode* reverseEvenLengthGroups(ListNode* head) {
        if (!head || !head->next) return head;

        ListNode* dummy = new ListNode(0, head);
        ListNode* prev = dummy;
        ListNode* curr = head;
        int group = 1;

        while (curr) {
            ListNode* groupPrev = prev;
            ListNode* groupHead = curr;
            int count = 0;

            while (curr && count < group) {
                prev = curr;
                curr = curr->next;
                count++;
            }

            if (count % 2 == 0) {
                prev = reverse(groupHead, count);
                groupPrev->next = prev;
                groupHead->next = curr;
                prev = groupHead;
            } else {
                prev = groupHead;
                for (int i = 1; i < count; ++i) {
                    prev = prev->next;
                }
            }

            group++;
        }

        return dummy->next;
    }

private:
    ListNode* reverse(ListNode* head, int k) {
        ListNode* prev = nullptr;
        ListNode* curr = head;
        for (int i = 0; i < k; ++i) {
            ListNode* next = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next;
        }
        return prev;
    }
};