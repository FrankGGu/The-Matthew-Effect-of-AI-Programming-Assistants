#include <iostream>
#include <vector>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
public:
    ListNode* reverseKGroup(ListNode* head, int k) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* prev = dummy;
        ListNode* curr = head;
        ListNode* next = nullptr;

        int count = 0;
        while (curr) {
            count++;
            if (count % k == 0) {
                ListNode* next_group = curr->next;
                ListNode* last = prev->next;
                ListNode* start = prev->next;
                for (int i = 0; i < k; i++) {
                    next = start->next;
                    start->next = prev;
                    prev = start;
                    start = next;
                }
                last->next = next_group;
                prev = last;
                curr = next_group;
            } else {
                curr = curr->next;
            }
        }

        return dummy->next;
    }
};