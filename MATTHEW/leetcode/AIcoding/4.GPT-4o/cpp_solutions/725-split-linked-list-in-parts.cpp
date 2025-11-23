class Solution {
public:
    vector<ListNode*> splitListToParts(ListNode* root, int k) {
        vector<ListNode*> parts(k, nullptr);
        int len = 0;
        ListNode* curr = root;

        while (curr) {
            len++;
            curr = curr->next;
        }

        int size = len / k, extra = len % k;
        curr = root;

        for (int i = 0; i < k; ++i) {
            parts[i] = curr;
            int currSize = size + (i < extra ? 1 : 0);
            for (int j = 0; j < currSize - 1; ++j) {
                if (curr) curr = curr->next;
            }
            if (curr) {
                ListNode* nextPart = curr->next;
                curr->next = nullptr;
                curr = nextPart;
            }
        }

        return parts;
    }
};