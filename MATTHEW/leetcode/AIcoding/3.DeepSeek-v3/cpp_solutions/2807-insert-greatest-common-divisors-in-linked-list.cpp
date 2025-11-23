class Solution {
public:
    int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    ListNode* insertGreatestCommonDivisors(ListNode* head) {
        if (head == nullptr || head->next == nullptr) {
            return head;
        }
        ListNode* current = head;
        while (current->next != nullptr) {
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
};