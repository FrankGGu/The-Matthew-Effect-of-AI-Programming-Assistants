#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int bestRotation(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> diff(n, 0);

        // For each element nums[i], it contributes a point if nums[i] <= (new_index).
        // The new_index for original nums[i] after k rotations is (i - k + n) % n.
        // So, nums[i] contributes if nums[i] <= (i - k + n) % n.
        //
        // This is equivalent to (i - k + n) % n being in the range [nums[i], n-1].
        //
        // Conversely, nums[i] *does not* contribute if (i - k + n) % n is in the range [0, nums[i]-1].
        // Let this "bad" range of new indices be [L, R], where L=0 and R=nums[i]-1.
        //
        // We need to find the range of k values for which (i - k + n) % n falls into [L, R].
        //
        // The k value that makes (i - k + n) % n equal to R is k_start_bad:
        // (i - k_start_bad + n) % n = R  =>  k_start_bad = (i - R + n) % n
        // k_start_bad = (i - (nums[i]-1) + n) % n = (i - nums[i] + 1 + n) % n
        //
        // The k value that makes (i - k + n) % n equal to L is k_end_bad:
        // (i - k_end_bad + n) % n = L  =>  k_end_bad = (i - L + n) % n
        // k_end_bad = (i - 0 + n) % n = i
        //
        // So, nums[i] does not contribute for k in the cyclic range [k_start_bad, k_end_bad].
        //
        // We use a difference array 'diff'.
        // diff[k] stores the change in score when moving from rotation k-1 to k.
        // A decrement at diff[start] and an increment at diff[(end + 1) % n] correctly models
        // a subtraction of 1 from the score over the cyclic range [start, end].

        for (int i = 0; i < n; ++i) {
            // If nums[i] == 0, then the "bad" range [0, nums[i]-1] is [0, -1], which is empty.
            // This means nums[i] will always contribute a point (since indices are >= 0).
            // Therefore, no changes to the difference array are needed for nums[i] == 0,
            // as its contribution status never changes.
            if (nums[i] == 0) {
                continue;
            }

            int k_start_bad = (i - nums[i] + 1 + n) % n;
            int k_end_bad = i;

            // Decrement score for k in the range [k_start_bad, k_end_bad] (cyclically).
            // This means at k_start_bad, the score effectively decreases by 1.
            diff[k_start_bad]--;
            // At (k_end_bad + 1) % n, the score effectively increases by 1,
            // cancelling the decrement for subsequent k values.
            diff[(k_end_bad + 1) % n]++;
        }

        // Calculate the initial score for k=0.
        // For k=0, nums[i] is at index i. It contributes if nums[i] <= i.
        int current_score = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] <= i) {
                current_score++;
            }
        }

        int max_score = current_score;
        int best_k = 0;

        // Calculate scores for k=1 to n-1 using the difference array.
        // score[k] = score[k-1] + diff[k].
        for (int k = 1; k < n; ++k) {
            current_score += diff[k];
            if (current_score > max_score) {
                max_score = current_score;
                best_k = k;
            }
            // If current_score == max_score, we keep the smallest k,
            // which is implicitly handled by not updating best_k in this case.
        }

        return best_k;
    }
};