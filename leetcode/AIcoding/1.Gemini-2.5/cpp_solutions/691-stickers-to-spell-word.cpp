#include <vector>
#include <string>
#include <algorithm>
#include <map>

class Solution {
public:
    int N; // target length
    std::vector<std::vector<int>> sticker_char_counts; // Precomputed counts for stickers
    std::vector<int> memo; // Memoization table

    int solve(int mask, const std::string& target) {
        if (mask == 0) {
            return 0; // All characters covered
        }
        if (memo[mask] != -1) {
            return memo[mask];
        }

        int res = INT_MAX;

        // Find the index of the first character in target that is still needed in `mask`
        int first_needed_char_idx = -1;
        for (int i = 0; i < N; ++i) {
            if ((mask >> i) & 1) {
                first_needed_char_idx = i;
                break;
            }
        }
        char char_to_cover = target[first_needed_char_idx];

        for (const auto& s_counts_orig : sticker_char_counts) {
            // Optimization: if the current sticker doesn't have the first needed character, skip it.
            // This prunes branches where a sticker cannot contribute to covering the "leftmost" needed character.
            if (s_counts_orig[char_to_cover - 'a'] == 0) {
                continue;
            }

            std::vector<int> current_s_counts = s_counts_orig; // Make a copy of sticker counts for this iteration

            int temp_mask = mask; // This mask will be reduced by the current sticker

            // Iterate through target characters to apply the sticker
            for (int i = 0; i < N; ++i) {
                if (((temp_mask >> i) & 1)) { // If target[i] is needed in temp_mask
                    if (current_s_counts[target[i] - 'a'] > 0) {
                        current_s_counts[target[i] - 'a']--;
                        temp_mask &= ~(1 << i); // Clear the bit for target[i] as it's covered
                    }
                }
            }

            // At this point, `temp_mask` represents the characters that still need to be covered
            // after using the current sticker to cover as many as possible from the original `mask`.
            // The `first_needed_char_idx` optimization ensures that `temp_mask` will always be different from `mask`
            // because the sticker has `char_to_cover` and `char_to_cover` is guaranteed to be in `mask`.

            int sub_res = solve(temp_mask, target);
            if (sub_res != INT_MAX) { // If the subproblem is solvable
                res = std::min(res, 1 + sub_res);
            }
        }

        return memo[mask] = res;
    }

    int stickersToSpellWord(std::vector<std::string>& stickers, std::string target) {
        N = target.length();
        memo.assign(1 << N, -1); // Initialize memoization table with -1

        // Precompute character counts for each sticker
        for (const std::string& s : stickers) {
            std::vector<int> counts(26, 0);
            for (char c : s) {
                counts[c - 'a']++;
            }
            sticker_char_counts.push_back(counts);
        }

        int result = solve((1 << N) - 1, target); // Start solving for the full target mask
        return (result == INT_MAX) ? -1 : result; // If INT_MAX, it's impossible to spell
    }
};