#include <iostream>
#include <vector>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution {
public:
    ListNode* rotateRight(ListNode* head, int k) {
        if (!head || !head->next || k == 0) return head;

        int length = 1;
        ListNode* tail = head;
        while (tail->next) {
            tail = tail->next;
            length++;
        }

        k = k % length;
        if (k == 0) return head;

        int stepsToGo = length - k - 1;
        ListNode* current = head;
        for (int i = 0; i < stepsToGo; ++i) {
            current = current->next;
        }

        ListNode* newHead = current->next;
        current->next = nullptr;
        tail->next = head;

        return newHead;
    }
};