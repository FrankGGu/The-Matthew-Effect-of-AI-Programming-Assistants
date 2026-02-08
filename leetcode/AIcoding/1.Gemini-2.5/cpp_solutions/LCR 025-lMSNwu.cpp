#include <stack> // Required for std::stack
struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        std::stack<int> s1;
        std::stack<int> s2;

        while (l1) {
            s1.push(l1->val);
            l1 = l1->next;
        }

        while (l2) {
            s2.push(l2->val);
            l2 = l2->next;
        }

        int carry = 0;
        ListNode* head = nullptr;

        while (!s1.empty() || !s2.empty() || carry != 0) {
            int val1 = s1.empty() ? 0 : s1.top();
            if (!s1.empty()) s1.pop();

            int val2 = s2.empty() ? 0 : s2.top();
            if (!s2.empty()) s2.pop();

            int sum = val1 + val2 + carry;
            carry = sum / 10;
            int digit = sum % 10;

            ListNode* newNode = new ListNode(digit);
            newNode->next = head;
            head = newNode;
        }

        return head;
    }
};