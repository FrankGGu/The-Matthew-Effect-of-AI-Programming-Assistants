class Solution {
public:
    vector<int> nodesBetweenCriticalPoints(ListNode* head) {
        if (!head || !head->next || !head->next->next) {
            return {-1, -1};
        }

        ListNode* prev = head;
        ListNode* curr = head->next;
        ListNode* next = curr->next;

        vector<int> criticalIndices;
        int index = 1;

        while (next) {
            if ((curr->val > prev->val && curr->val > next->val) || 
                (curr->val < prev->val && curr->val < next->val)) {
                criticalIndices.push_back(index);
            }
            prev = curr;
            curr = next;
            next = next->next;
            index++;
        }

        if (criticalIndices.size() < 2) {
            return {-1, -1};
        }

        int minDist = INT_MAX;
        for (int i = 1; i < criticalIndices.size(); ++i) {
            minDist = min(minDist, criticalIndices[i] - criticalIndices[i-1]);
        }

        int maxDist = criticalIndices.back() - criticalIndices.front();

        return {minDist, maxDist};
    }
};