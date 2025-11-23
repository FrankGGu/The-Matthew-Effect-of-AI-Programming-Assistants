class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        ListNode* prev = nullptr;
        ListNode* curr = head;
        while (curr) {
            ListNode* next_temp = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next_temp;
        }
        return prev;
    }

    int pairSum(ListNode* head) {
        ListNode* slow = head;
        ListNode* fast = head;

        while (fast->next && fast->next->next) {
            slow = slow->next;
            fast = fast->next->next;
        }

        ListNode* second_half_head = slow->next;
        slow->next = nullptr; 

        ListNode* reversed_second_half = reverseList(second_half_head);

        int max_twin_sum = 0;
        ListNode* p1 = head;
        ListNode* p2 = reversed_second_half;

        while (p1 && p2) {
            max_twin_sum = std::max(max_twin_sum, p1->val + p2->val);
            p1 = p1->next;
            p2 = p2->next;
        }

        return max_twin_sum;
    }
};