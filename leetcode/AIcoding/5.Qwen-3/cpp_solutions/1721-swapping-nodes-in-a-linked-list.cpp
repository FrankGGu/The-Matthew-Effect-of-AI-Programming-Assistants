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
    ListNode* swapNodes(ListNode* head, int k) {
        ListNode* first = head;
        for (int i = 0; i < k - 1; ++i) {
            first = first->next;
        }

        ListNode* second = head;
        ListNode* tail = first;
        while (tail->next) {
            tail = tail->next;
            second = second->next;
        }

        int temp = first->val;
        first->val = second->val;
        second->val = temp;

        return head;
    }
};