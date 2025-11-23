#include <vector>

class Solution {
public:
    int numTeams(std::vector<int>& rating) {
        int n = rating.size();
        if (n < 3) {
            return 0;
        }

        int total_teams = 0;

        for (int j = 1; j < n - 1; ++j) {
            int left_smaller = 0;
            int left_greater = 0;
            int right_smaller = 0;
            int right_greater = 0;

            for (int i = 0; i < j; ++i) {
                if (rating[i] < rating[j]) {
                    left_smaller++;
                } else if (rating[i] > rating[j]) {
                    left_greater++;
                }
            }

            for (int k = j + 1; k < n; ++k) {
                if (rating[k] < rating[j]) {
                    right_smaller++;
                } else if (rating[k] > rating[j]) {
                    right_greater++;
                }
            }

            total_teams += left_smaller * right_greater;
            total_teams += left_greater * right_smaller;
        }

        return total_teams;
    }
};