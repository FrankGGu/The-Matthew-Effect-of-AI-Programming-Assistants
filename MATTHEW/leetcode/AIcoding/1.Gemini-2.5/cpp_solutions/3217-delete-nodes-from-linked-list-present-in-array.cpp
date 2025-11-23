#include <vector>
#include <unordered_set>

class Solution {
public:
    ListNode* deleteNodes(ListNode* head, std::vector<int>& nums) {
        std::unordered_set<int> to_delete_set;
        for (int num : nums) {
            to_delete_set.insert(num);
        }

        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* current = head;
        ListNode* prev = dummy;

        while (current != nullptr) {
            if (to_delete_set.count(current->val)) {
                prev->next = current->next;
                current = current->next;
            } else {
                prev = current;
                current = current->next;
            }
        }

        ListNode* new_head = dummy->next;
        delete dummy; 
        return new_head;
    }
};