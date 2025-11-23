#include <vector>
#include <algorithm> // For std::min
#include <limits>    // For std::numeric_limits

class Solution {
public:
    std::vector<int> nodesBetweenCriticalPoints(ListNode* head) {
        std::vector<int> criticalPointsIndices;

        // A linked list must have at least 3 nodes to have any critical points.
        // head (index 0), head->next (index 1), head->next->next (index 2)
        // The first and last nodes cannot be critical points.
        // So, we need at least head->next->next to be non-null.
        if (!head || !head->next || !head->next->next) {
            return {-1, -1};
        }

        ListNode* prev = head;
        ListNode* curr = head->next;
        int index = 1; // 'curr' is at index 1 (0-indexed head)

        // Iterate until 'curr' is the second to last node (curr->next is the last node)
        while (curr->next != nullptr) {
            // Check if 'curr' is a critical point
            // A node is a critical point if its value is strictly greater than both its neighbors
            // or strictly smaller than both its neighbors.
            if ((curr->val > prev->val && curr->val > curr->next->val) ||
                (curr->val < prev->val && curr->val < curr->next->val)) {
                criticalPointsIndices.push_back(index);
            }

            prev = curr;
            curr = curr->next;
            index++;
        }

        // If fewer than two critical points are found, return {-1, -1}
        if (criticalPointsIndices.size() < 2) {
            return {-1, -1};
        }

        int minDistance = std::numeric_limits<int>::max();
        // The maximum distance is simply the distance between the first and last critical point found
        int maxDistance = criticalPointsIndices.back() - criticalPointsIndices.front();

        // Calculate the minimum distance between any two adjacent critical points
        for (size_t i = 0; i < criticalPointsIndices.size() - 1; ++i) {
            minDistance = std::min(minDistance, criticalPointsIndices[i+1] - criticalPointsIndices[i]);
        }

        return {minDistance, maxDistance};
    }
};