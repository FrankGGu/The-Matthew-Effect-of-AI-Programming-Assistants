#include <iostream>
#include <vector>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

class Solution {
public:
    ListNode* insertionSortList(ListNode* head) {
        if (!head || !head->next) return head;

        ListNode dummy(0);
        dummy.next = head;
        ListNode* lastSorted = head;
        ListNode* current = head->next;

        while (current) {
            if (lastSorted->val <= current->val) {
                lastSorted = current;
                current = current->next;
                continue;
            }

            ListNode* prev = &dummy;
            while (prev->next->val < current->val) {
                prev = prev->next;
            }

            ListNode* nextNode = current->next;
            current->next = prev->next;
            prev->next = current;
            lastSorted->next = nextNode;

            current = nextNode;
        }

        return dummy.next;
    }
};