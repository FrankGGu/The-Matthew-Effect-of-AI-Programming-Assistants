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
    ListNode* doubleIt(ListNode* head) {
        if (!head) return nullptr;

                ListNode* prev = nullptr;
        ListNode* curr = head;
        while (curr) {
            ListNode* next = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next;
        }
        head = prev;

                int carry = 0;
        curr = head;
        while (curr) {
            int total = curr->val * 2 + carry;
            curr->val = total % 10;
            carry = total / 10;
            curr = curr->next;
        }

                if (carry > 0) {
            ListNode* new_node = new ListNode(carry);
            new_node->next = head;
            head = new_node;
        }

                prev = nullptr;
        curr = head;
        while (curr) {
            ListNode* next = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next;
        }
        head = prev;

        return head;
    }
};