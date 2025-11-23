class Solution {
public:
    std::vector<ListNode*> splitListToParts(ListNode* head, int k) {
        int n = 0;
        ListNode* current = head;
        while (current) {
            n++;
            current = current->next;
        }

        int base_size = n / k;
        int extra_parts = n % k;

        std::vector<ListNode*> result(k, nullptr);
        current = head;

        for (int i = 0; i < k; ++i) {
            result[i] = current;
            if (!current) {
                continue;
            }

            int part_size = base_size + (i < extra_parts ? 1 : 0);

            for (int j = 0; j < part_size - 1; ++j) {
                if (current) {
                    current = current->next;
                }
            }

            if (current) {
                ListNode* next_head = current->next;
                current->next = nullptr;
                current = next_head;
            }
        }

        return result;
    }
};