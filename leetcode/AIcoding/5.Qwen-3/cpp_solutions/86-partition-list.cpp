#include <iostream>
#include <vector>
#include <ListNode.h>

using namespace std;

class Solution {
public:
    ListNode* partition(ListNode* head, int x) {
        ListNode* dummy1 = new ListNode(0);
        ListNode* dummy2 = new ListNode(0);
        ListNode* p = head;
        ListNode* q = dummy1;
        ListNode* r = dummy2;

        while (p) {
            if (p->val < x) {
                q->next = p;
                q = q->next;
            } else {
                r->next = p;
                r = r->next;
            }
            p = p->next;
        }

        q->next = dummy2->next;
        r->next = nullptr;

        return dummy1->next;
    }
};