class ListNode {
public:
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution {
public:
    ListNode* reverseKGroup(ListNode* head, int k) {
        ListNode dummy(0);
        dummy.next = head;
        ListNode* prevGroupEnd = &dummy;

        while (true) {
            ListNode* groupStart = prevGroupEnd->next;
            ListNode* groupEnd = prevGroupEnd;
            for (int i = 0; i < k; i++) {
                groupEnd = groupEnd->next;
                if (!groupEnd) return dummy.next;
            }
            ListNode* nextGroupStart = groupEnd->next;
            groupEnd->next = nullptr;
            prevGroupEnd->next = reverseList(groupStart);
            groupStart->next = nextGroupStart;
            prevGroupEnd = groupStart;
        }
    }

private:
    ListNode* reverseList(ListNode* head) {
        ListNode* prev = nullptr;
        while (head) {
            ListNode* next = head->next;
            head->next = prev;
            prev = head;
            head = next;
        }
        return prev;
    }
};