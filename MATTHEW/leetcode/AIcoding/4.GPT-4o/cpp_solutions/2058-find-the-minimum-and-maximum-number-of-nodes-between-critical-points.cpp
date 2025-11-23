class Solution {
public:
    vector<int> nodesBetweenCriticalPoints(ListNode* head) {
        vector<int> criticalPoints;
        int index = 0;
        ListNode* prev = nullptr;
        ListNode* curr = head;
        ListNode* next = head ? head->next : nullptr;

        while (next) {
            if ((curr->val > prev->val && curr->val > next->val) || 
                (curr->val < prev->val && curr->val < next->val)) {
                criticalPoints.push_back(index);
            }
            prev = curr;
            curr = next;
            next = next->next;
            index++;
        }

        if (criticalPoints.size() < 2) return {-1, -1};

        int minDistance = INT_MAX;
        for (int i = 1; i < criticalPoints.size(); i++) {
            minDistance = min(minDistance, criticalPoints[i] - criticalPoints[i - 1]);
        }

        return {minDistance, criticalPoints.back() - criticalPoints.front()};
    }
};