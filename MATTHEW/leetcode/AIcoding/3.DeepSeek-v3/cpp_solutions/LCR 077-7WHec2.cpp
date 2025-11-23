class Solution {
public:
    ListNode* sortList(ListNode* head) {
        if (!head || !head->next) return head;

        int n = 0;
        ListNode* p = head;
        while (p) {
            n++;
            p = p->next;
        }

        ListNode dummy(0);
        dummy.next = head;

        for (int step = 1; step < n; step <<= 1) {
            ListNode* tail = &dummy;
            ListNode* cur = dummy.next;

            while (cur) {
                ListNode* left = cur;
                ListNode* right = split(left, step);
                cur = split(right, step);

                tail->next = merge(left, right);
                while (tail->next) {
                    tail = tail->next;
                }
            }
        }
        return dummy.next;
    }

private:
    ListNode* split(ListNode* head, int n) {
        while (--n && head) {
            head = head->next;
        }
        if (!head) return nullptr;
        ListNode* next = head->next;
        head->next = nullptr;
        return next;
    }

    ListNode* merge(ListNode* l1, ListNode* l2) {
        ListNode dummy(0);
        ListNode* p = &dummy;
        while (l1 && l2) {
            if (l1->val < l2->val) {
                p->next = l1;
                l1 = l1->next;
            } else {
                p->next = l2;
                l2 = l2->next;
            }
            p = p->next;
        }
        p->next = l1 ? l1 : l2;
        return dummy.next;
    }
};