class Solution {
public:
    int pairSum(ListNode* head) {
        ListNode* slow = head;
        ListNode* fast = head;
        while (fast != nullptr && fast->next != nullptr) {
            slow = slow->next;
            fast = fast->next->next;
        }

        ListNode* prev = nullptr;
        ListNode* curr = slow;
        ListNode* next = nullptr;
        while (curr != nullptr) {
            next = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next;
        }

        ListNode* first = head;
        ListNode* second = prev;
        int maxSum = 0;
        while (second != nullptr) {
            maxSum = max(maxSum, first->val + second->val);
            first = first->next;
            second = second->next;
        }
        return maxSum;
    }
};