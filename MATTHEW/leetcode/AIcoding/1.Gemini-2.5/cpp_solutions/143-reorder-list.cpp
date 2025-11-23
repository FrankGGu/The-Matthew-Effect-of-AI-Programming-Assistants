class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        ListNode* prev = nullptr;
        ListNode* curr = head;
        while (curr != nullptr) {
            ListNode* next_temp = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next_temp;
        }
        return prev;
    }

    void reorderList(ListNode* head) {
        if (head == nullptr || head->next == nullptr) {
            return;
        }

        ListNode* slow = head;
        ListNode* fast = head;
        ListNode* prev_slow = nullptr;

        while (fast != nullptr && fast->next != nullptr) {
            prev_slow = slow;
            slow = slow->next;
            fast = fast->next->next;
        }

        if (prev_slow != nullptr) {
            prev_slow->next = nullptr;
        }

        ListNode* first_half_head = head;
        ListNode* second_half_head = slow;

        ListNode* reversed_second_half_head = reverseList(second_half_head);

        ListNode* p1 = first_half_head;
        ListNode* p2 = reversed_second_half_head;

        while (p1 != nullptr && p2 != nullptr) {
            ListNode* p1_next_temp = p1->next;
            ListNode* p2_next_temp = p2->next;

            p1->next = p2;
            if (p1_next_temp == nullptr) {
                p2->next = p2_next_temp;
            } else {
                p2->next = p1_next_temp;
            }

            p1 = p1_next_temp;
            p2 = p2_next_temp;
        }
    }
};