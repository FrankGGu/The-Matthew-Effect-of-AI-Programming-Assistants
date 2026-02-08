#include <vector>
#include <string>
#include <queue>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> movesToStamp(std::string stamp, std::string target) {
        int N = target.length();
        int M = stamp.length();

        std::vector<int> ans;
        std::queue<int> q; // Stores indices of stamps that have been "unstamped"

        // match_info[i].first: count of characters in target[i...i+M-1] that match stamp and are not yet wildcards.
        // match_info[i].second: count of characters in target[i...i+M-1] that mismatch stamp and are not yet wildcards.
        // When match_info[i].second becomes 0, it means target[i...i+M-1] can be "unstamped".
        // If match_info[i].first also becomes 0, it means target[i...i+M-1] is already all wildcards.
        std::vector<std::pair<int, int>> match_info(N - M + 1);

        // target_is_wildcard[j] is true if target[j] has effectively become a '?'
        std::vector<bool> target_is_wildcard(N, false);

        // Initialize match_info for all possible stamp positions
        for (int i = 0; i <= N - M; ++i) {
            for (int k = 0; k < M; ++k) {
                if (target[i + k] == stamp[k]) {
                    match_info[i].first++;
                } else {
                    match_info[i].second++;
                }
            }
            // If there are no mismatches, this window is a candidate to be "unstamped"
            if (match_info[i].second == 0) {
                q.push(i);
                // Mark this window as processed by setting its first count to 0.
                // This prevents it from being added to the queue again later.
                // We only care about the second count (mismatches) for future pushes.
                match_info[i].first = 0; 
            }
        }

        int wildcard_count = 0; // Number of characters in target that are '?'

        while (!q.empty()) {
            int idx = q.front();
            q.pop();

            ans.push_back(idx);

            // For each character covered by this stamp at 'idx'
            for (int k = 0; k < M; ++k) {
                // If this character hasn't been turned into a wildcard yet
                if (!target_is_wildcard[idx + k]) {
                    target_is_wildcard[idx + k] = true;
                    wildcard_count++;

                    // This character target[idx + k] becoming '?' might affect other overlapping windows
                    // Iterate over all stamp positions 'j' that overlap with 'idx + k'
                    // A window 'j' covers target[j...j+M-1]
                    // 'idx+k' is covered by 'j' if j <= idx+k < j+M
                    // So, j is in [idx+k - M + 1, idx+k]
                    for (int j = std::max(0, idx + k - M + 1); j <= std::min(N - M, idx + k); ++j) {
                        // The character target[idx+k] corresponds to stamp[ (idx+k) - j ] in window 'j'
                        int char_in_stamp_idx = (idx + k) - j;

                        // Decrement the appropriate count for window 'j'
                        // We use the original 'target' character to determine if it was a match or mismatch
                        if (target[idx+k] == stamp[char_in_stamp_idx]) {
                            match_info[j].first--;
                        } else {
                            match_info[j].second--;
                        }

                        // If window 'j' now has no mismatches and still has active non-'?' characters,
                        // it means it's a new candidate to be "unstamped".
                        // The condition `match_info[j].first > 0` ensures it hasn't been pushed to queue yet.
                        if (match_info[j].second == 0 && match_info[j].first > 0) {
                            q.push(j);
                            match_info[j].first = 0; // Mark as processed/queued
                        }
                    }
                }
            }
        }

        // If all characters in target have become wildcards, then it's possible
        if (wildcard_count == N) {
            std::reverse(ans.begin(), ans.end()); // Reverse to get the correct stamping order
            return ans;
        } else {
            return {}; // Not possible
        }
    }
};