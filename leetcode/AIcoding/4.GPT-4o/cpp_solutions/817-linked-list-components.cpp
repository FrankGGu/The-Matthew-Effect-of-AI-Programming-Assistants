class Solution {
public:
    int numComponents(ListNode* head, vector<int>& G) {
        unordered_set<int> setG(G.begin(), G.end());
        int count = 0;
        bool inComponent = false;

        while (head) {
            if (setG.count(head->val)) {
                if (!inComponent) {
                    count++;
                    inComponent = true;
                }
            } else {
                inComponent = false;
            }
            head = head->next;
        }

        return count;
    }
};