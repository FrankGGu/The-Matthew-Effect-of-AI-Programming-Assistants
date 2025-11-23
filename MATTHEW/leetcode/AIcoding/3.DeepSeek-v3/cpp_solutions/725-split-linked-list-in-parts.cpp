class Solution {
public:
    vector<ListNode*> splitListToParts(ListNode* head, int k) {
        int length = 0;
        ListNode* curr = head;
        while (curr) {
            length++;
            curr = curr->next;
        }

        int part_size = length / k;
        int extra = length % k;

        vector<ListNode*> result(k, nullptr);
        curr = head;
        for (int i = 0; i < k && curr; ++i) {
            result[i] = curr;
            int current_part_size = part_size + (extra-- > 0 ? 1 : 0);
            for (int j = 0; j < current_part_size - 1; ++j) {
                curr = curr->next;
            }
            ListNode* next = curr->next;
            curr->next = nullptr;
            curr = next;
        }

        return result;
    }
};