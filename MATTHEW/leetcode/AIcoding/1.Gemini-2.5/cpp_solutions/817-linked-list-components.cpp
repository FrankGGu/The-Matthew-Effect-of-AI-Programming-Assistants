class Solution {
public:
    int numComponents(ListNode* head, std::vector<int>& G) {
        bool present[10000] = {false};
        for (int val : G) {
            present[val] = true;
        }

        int count = 0;
        bool in_component = false;
        ListNode* current = head;

        while (current != nullptr) {
            if (present[current->val]) {
                if (!in_component) {
                    count++;
                    in_component = true;
                }
            } else {
                in_component = false;
            }
            current = current->next;
        }
        return count;
    }
};