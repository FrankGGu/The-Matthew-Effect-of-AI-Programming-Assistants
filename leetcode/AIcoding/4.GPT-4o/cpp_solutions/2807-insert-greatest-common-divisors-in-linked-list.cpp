class Solution {
public:
    ListNode* insertGCDs(ListNode* head) {
        if (!head) return nullptr;

        ListNode* current = head;
        while (current && current->next) {
            int gcdValue = gcd(current->val, current->next->val);
            ListNode* newNode = new ListNode(gcdValue);
            newNode->next = current->next;
            current->next = newNode;
            current = newNode->next;
        }

        return head;
    }

    int gcd(int a, int b) {
        while (b) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};