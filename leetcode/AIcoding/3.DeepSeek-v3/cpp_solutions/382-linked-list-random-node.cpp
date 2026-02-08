class Solution {
private:
    ListNode* head;
public:
    Solution(ListNode* head) {
        this->head = head;
    }

    int getRandom() {
        int scope = 1, chosenValue = 0;
        ListNode* curr = head;
        while (curr) {
            if (rand() % scope == 0) {
                chosenValue = curr->val;
            }
            scope++;
            curr = curr->next;
        }
        return chosenValue;
    }
};