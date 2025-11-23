#include <unordered_set>

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution {
public:
    ListNode* deleteNodes(ListNode* head, std::vector<int>& to_delete) {
        std::unordered_set<int> delete_set(to_delete.begin(), to_delete.end());
        ListNode dummy(0);
        dummy.next = head;
        ListNode* current = &dummy;

        while (current->next) {
            if (delete_set.count(current->next->val)) {
                ListNode* to_delete_node = current->next;
                current->next = current->next->next;
                delete to_delete_node;
            } else {
                current = current->next;
            }
        }
        return dummy.next;
    }
};