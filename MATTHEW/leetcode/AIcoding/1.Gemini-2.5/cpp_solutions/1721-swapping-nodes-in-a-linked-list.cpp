class Solution {
public:
    ListNode* swapNodes(ListNode* head, int k) {
        ListNode* first_node_ptr = head;
        ListNode* current_ptr = head;

        // Move current_ptr to the k-th node from the beginning
        // first_node_ptr will also point to this node
        for (int i = 1; i < k; ++i) {
            current_ptr = current_ptr->next;
        }
        first_node_ptr = current_ptr;

        ListNode* second_node_ptr = head;
        // Now, move current_ptr to the end of the list.
        // As current_ptr moves, second_node_ptr will trail it,
        // ending up at the k-th node from the end.
        while (current_ptr->next != nullptr) {
            current_ptr = current_ptr->next;
            second_node_ptr = second_node_ptr->next;
        }

        // Swap the values of the two nodes
        int temp = first_node_ptr->val;
        first_node_ptr->val = second_node_ptr->val;
        second_node_ptr->val = temp;

        return head;
    }
};