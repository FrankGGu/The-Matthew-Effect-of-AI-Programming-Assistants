#include <iostream>
#include <vector>
#include <algorithm>

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
    ListNode* insertGreatestCommonDivisors(ListNode* head) {
        if (!head || !head->next) return head;

        ListNode* current = head;
        while (current->next) {
            int a = current->val;
            int b = current->next->val;
            int gcd_val = gcd(a, b);
            ListNode* new_node = new ListNode(gcd_val);
            new_node->next = current->next;
            current->next = new_node;
            current = new_node->next;
        }

        return head;
    }

private:
    int gcd(int a, int b) {
        while (b) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};