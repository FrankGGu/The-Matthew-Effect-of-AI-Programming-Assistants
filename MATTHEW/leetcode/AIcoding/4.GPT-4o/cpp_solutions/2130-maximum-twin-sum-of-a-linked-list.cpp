class Solution {
public:
    int pairSum(ListNode* head) {
        vector<int> vals;
        ListNode* curr = head;
        while (curr) {
            vals.push_back(curr->val);
            curr = curr->next;
        }
        int n = vals.size();
        int maxSum = 0;
        for (int i = 0; i < n / 2; ++i) {
            maxSum = max(maxSum, vals[i] + vals[n - 1 - i]);
        }
        return maxSum;
    }
};