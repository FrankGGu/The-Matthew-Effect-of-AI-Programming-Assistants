#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    vector<int> nodesBetweenCriticalPoints(ListNode* head) {
        vector<int> result;
        if (!head || !head->next || !head->next->next) {
            return {-1, -1};
        }

        ListNode* prev = head;
        ListNode* curr = head->next;
        int firstCriticalIndex = -1;
        int lastCriticalIndex = -1;
        int minDistance = INT_MAX;
        int index = 1;

        while (curr->next) {
            if ((curr->val > prev->val && curr->val > curr->next->val) || 
                (curr->val < prev->val && curr->val < curr->next->val)) {
                if (firstCriticalIndex == -1) {
                    firstCriticalIndex = index;
                } else {
                    minDistance = min(minDistance, index - lastCriticalIndex);
                }
                lastCriticalIndex = index;
            }
            prev = curr;
            curr = curr->next;
            index++;
        }

        if (firstCriticalIndex == -1 || lastCriticalIndex == firstCriticalIndex) {
            return {-1, -1};
        }

        int maxDistance = lastCriticalIndex - firstCriticalIndex;
        result.push_back(minDistance);
        result.push_back(maxDistance);
        return result;
    }
};