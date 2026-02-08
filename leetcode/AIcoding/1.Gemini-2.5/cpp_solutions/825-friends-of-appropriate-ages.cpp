#include <vector>
#include <numeric>

class Solution {
public:
    int numFriendRequests(std::vector<int>& ages) {
        std::vector<int> counts(121, 0);
        for (int age : ages) {
            counts[age]++;
        }

        std::vector<int> prefix_sum(121, 0);
        for (int i = 1; i <= 120; ++i) {
            prefix_sum[i] = prefix_sum[i - 1] + counts[i];
        }

        int total_requests = 0;
        for (int ageA = 15; ageA <= 120; ++ageA) {
            if (counts[ageA] == 0) {
                continue;
            }

            int min_ageB = ageA / 2 + 7;

            int count_recipients = prefix_sum[ageA] - prefix_sum[min_ageB];

            total_requests += counts[ageA] * (count_recipients - 1);
        }

        return total_requests;
    }
};