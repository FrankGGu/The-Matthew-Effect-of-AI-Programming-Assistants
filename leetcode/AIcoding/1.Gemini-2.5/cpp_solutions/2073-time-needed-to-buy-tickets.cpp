#include <vector>
#include <algorithm>

class Solution {
public:
    int timeRequiredToBuy(std::vector<int>& tickets, int k) {
        int n = tickets.size();
        int time = 0;
        int target_tickets_for_k = tickets[k];

        for (int i = 0; i < n; ++i) {
            if (i <= k) {
                time += std::min(tickets[i], target_tickets_for_k);
            } else {
                time += std::min(tickets[i], target_tickets_for_k - 1);
            }
        }
        return time;
    }
};