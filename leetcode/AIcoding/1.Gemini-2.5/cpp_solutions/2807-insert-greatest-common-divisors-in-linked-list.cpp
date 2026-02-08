#include <numeric> // For std::gcd

class Solution {
public:
    ListNode* insertGreatestCommonDivisors(ListNode* head) {
        if (head == nullptr || head->next == nullptr) {
            return head;
        }

        ListNode* current = head;
        while (current != nullptr && current->next != nullptr) {
            int gcd_val = std::gcd(current->val, current->next->val);
            ListNode* new_node = new ListNode(gcd_val);

            new_node->next = current->next;
            current->next = new_node;

            current = new_node->next;
        }

        return head;
    }
};