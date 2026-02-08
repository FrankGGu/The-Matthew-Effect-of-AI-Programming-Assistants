class Solution {
public:
    vector<ListNode*> splitListToParts(ListNode* head, int k) {
        int len = 0;
        ListNode* temp = head;
        while (temp != nullptr) {
            len++;
            temp = temp->next;
        }

        int base_size = len / k;
        int extra = len % k;

        vector<ListNode*> result(k, nullptr);
        temp = head;
        for (int i = 0; i < k; i++) {
            result[i] = temp;
            int current_size = base_size;
            if (i < extra) {
                current_size++;
            }

            if (temp == nullptr) continue;

            for (int j = 1; j < current_size; j++) {
                temp = temp->next;
            }

            ListNode* next_head = nullptr;
            if (temp != nullptr) {
                next_head = temp->next;
                temp->next = nullptr;
            }
            temp = next_head;
        }

        return result;
    }
};