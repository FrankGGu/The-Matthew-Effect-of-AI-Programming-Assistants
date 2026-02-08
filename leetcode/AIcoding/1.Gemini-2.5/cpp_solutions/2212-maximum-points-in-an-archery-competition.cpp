#include <vector>
#include <numeric>

class Solution {
public:
    int max_score;
    std::vector<int> result_bob_arrows;
    std::vector<int> alice_arrows_global;
    int num_arrows_global;

    void backtrack(int idx, int current_arrows_used, int current_score, std::vector<int>& current_bob_arrows) {
        if (idx == 12) {
            current_bob_arrows[0] += (num_arrows_global - current_arrows_used);

            if (current_score > max_score) {
                max_score = current_score;
                result_bob_arrows = current_bob_arrows;
            }

            current_bob_arrows[0] -= (num_arrows_global - current_arrows_used);
            return;
        }

        current_bob_arrows[idx] = 0;
        backtrack(idx + 1, current_arrows_used, current_score, current_bob_arrows);

        int arrows_needed_to_win = alice_arrows_global[idx] + 1;
        if (current_arrows_used + arrows_needed_to_win <= num_arrows_global) {
            current_bob_arrows[idx] = arrows_needed_to_win;
            backtrack(idx + 1, current_arrows_used + arrows_needed_to_win, current_score + idx, current_bob_arrows);
        }
    }

    std::vector<int> maximumBobPoints(int numArrows, std::vector<int>& aliceArrows) {
        max_score = -1;
        result_bob_arrows.assign(12, 0);
        alice_arrows_global = aliceArrows;
        num_arrows_global = numArrows;

        std::vector<int> current_bob_arrows(12, 0);
        backtrack(0, 0, 0, current_bob_arrows);

        return result_bob_arrows;
    }
};