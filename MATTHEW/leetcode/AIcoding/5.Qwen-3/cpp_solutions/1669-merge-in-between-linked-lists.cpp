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
    ListNode* mergeInBetween(ListNode* list1, int a, int b) {
        ListNode* dummy = new ListNode(0);
        dummy->next = list1;
        ListNode* prev = dummy;
        for (int i = 0; i < a; ++i) {
            prev = prev->next;
        }
        ListNode* curr = prev->next;
        for (int i = 0; i <= b - a; ++i) {
            ListNode* temp = curr->next;
            delete curr;
            curr = temp;
        }
        prev->next = curr;
        return dummy->next;
    }
};