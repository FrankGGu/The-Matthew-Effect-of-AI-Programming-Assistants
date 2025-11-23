#include <vector>
#include <numeric> // For std::accumulate

class Solution {
public:
    std::vector<int> balls_ref;
    int total_balls_sum;
    int target_balls_per_box;
    long long favorable_ways;
    long long total_ways;

    void backtrack(int color_idx, int b1_count, int b2_count, int b1_distinct, int b2_distinct) {
        // Base case: all colors have been processed
        if (color_idx == balls_ref.size()) {
            // Check if both boxes have exactly target_balls_per_box balls
            if (b1_count == target_balls_per_box && b2_count == target_balls_per_box) {
                // This is a valid distribution for total balls
                total_ways++;
                // Check if the number of distinct colors is the same
                if (b1_distinct == b2_distinct) {
                    favorable_ways++;
                }
            }
            return;
        }

        // Recursive step: For the current color_idx, distribute its balls
        int num_balls_of_current_color = balls_ref[color_idx];

        // Iterate through all possible ways to distribute num_balls_of_current_color balls:
        // 'j' balls go to box 1, and 'num_balls_of_current_color - j' balls go to box 2.
        // Balls of the same color are considered indistinguishable.
        for (int j = 0; j <= num_balls_of_current_color; ++j) {
            int next_b1_count = b1_count + j;
            int next_b2_count = b2_count + (num_balls_of_current_color - j);

            // Early pruning: If adding these balls would cause either box to exceed its target,
            // this branch cannot lead to a valid solution. Skip it.
            if (next_b1_count > target_balls_per_box || next_b2_count > target_balls_per_box) {
                continue;
            }

            // Determine if this color contributes to distinct count for each box
            int next_b1_distinct = b1_distinct + (j > 0 ? 1 : 0);
            int next_b2_distinct = b2_distinct + (num_balls_of_current_color - j > 0 ? 1 : 0);

            // Recursively call for the next color
            backtrack(color_idx + 1, next_b1_count, next_b2_count, 
                      next_b1_distinct, next_b2_distinct);
        }
    }

    double getProbability(std::vector<int>& balls) {
        balls_ref = balls;
        total_balls_sum = std::accumulate(balls.begin(), balls.end(), 0);

        // The problem statement guarantees sum(balls) is even.
        target_balls_per_box = total_balls_sum / 2;

        favorable_ways = 0;
        total_ways = 0;

        // Start the backtracking process from the first color (index 0),
        // with both boxes initially empty (0 balls, 0 distinct colors).
        backtrack(0, 0, 0, 0, 0);

        // If no valid distributions were found (should not happen for sum(balls) >= 2),
        // return 0.0 to avoid division by zero.
        if (total_ways == 0) {
            return 0.0; 
        }

        // Calculate the probability as (favorable ways) / (total ways).
        // Cast to long double for division to ensure precision before casting to double.
        return static_cast<double>(static_cast<long double>(favorable_ways) / total_ways);
    }
};