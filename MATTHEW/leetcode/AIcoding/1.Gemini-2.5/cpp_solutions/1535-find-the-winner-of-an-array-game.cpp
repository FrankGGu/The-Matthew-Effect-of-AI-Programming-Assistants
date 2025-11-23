#include <vector>

class Solution {
public:
    int findTheWinner(std::vector<int>& arr, int k) {
        int n = arr.size();

        int current_winner = arr[0];
        int consecutive_wins = 0;

        for (int i = 1; i < n; ++i) {
            if (current_winner > arr[i]) {
                consecutive_wins++;
            } else {
                current_winner = arr[i];
                consecutive_wins = 1;
            }

            if (consecutive_wins == k) {
                return current_winner;
            }
        }

        return current_winner;
    }
};