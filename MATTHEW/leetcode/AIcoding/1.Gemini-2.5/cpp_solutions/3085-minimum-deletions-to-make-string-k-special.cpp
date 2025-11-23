#include <string>
#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    int minimumDeletions(std::string s, int k) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        std::vector<int> counts(26, 0);
        for (char ch : s) {
            counts[ch - 'a']++;
        }

        std::set<int> candidate_freq_values_set;
        candidate_freq_values_set.insert(0);
        candidate_freq_values_set.insert(k);
        candidate_freq_values_set.insert(n); // Max possible frequency

        for (int freq : counts) {
            if (freq > 0) {
                candidate_freq_values_set.insert(freq);
                if (freq - 1 >= 0) {
                    candidate_freq_values_set.insert(freq - 1);
                }
                if (freq + 1 <= n) { // Max freq can't exceed n
                    candidate_freq_values_set.insert(freq + 1);
                }
            }
        }

        std::vector<int> candidate_freq_values(candidate_freq_values_set.begin(), candidate_freq_values_set.end());

        int min_deletions = n;

        for (int min_f : candidate_freq_values) {
            // Ensure min_f is within valid range [0, n]
            if (min_f < 0 || min_f > n) {
                continue;
            }

            for (int max_f : candidate_freq_values) {
                // Ensure max_f is within valid range [0, n]
                if (max_f < 0 || max_f > n) {
                    continue;
                }

                // Conditions for a valid (min_f, max_f) range
                if (min_f > max_f) {
                    continue;
                }
                if (max_f - min_f > k) {
                    continue;
                }

                int current_deletions = 0;
                bool is_valid_config = true;
                bool any_char_kept = false;

                for (int i = 0; i < 26; ++i) {
                    int freq = counts[i];
                    if (freq == 0) {
                        continue; // Character not present, no deletions needed
                    }

                    if (freq < min_f) {
                        current_deletions += freq; // Delete all occurrences of this character
                    } else if (freq > max_f) {
                        current_deletions += (freq - max_f); // Reduce frequency to max_f
                        if (max_f < k) { // The final frequency (max_f) must be at least k
                            is_valid_config = false;
                            break;
                        }
                        any_char_kept = true;
                    } else { // min_f <= freq <= max_f
                        // Keep all occurrences of this character
                        if (freq < k) { // The final frequency (freq) must be at least k
                            is_valid_config = false;
                            break;
                        }
                        any_char_kept = true;
                    }
                }

                if (is_valid_config) {
                    // A configuration is valid if:
                    // 1. All kept characters have frequency >= k (checked by is_valid_config)
                    // 2. The difference between max_f and min_f is <= k (checked earlier)
                    // 3. Either at least one character is kept, or the string becomes empty (all characters deleted).
                    if (any_char_kept || current_deletions == n) {
                        min_deletions = std::min(min_deletions, current_deletions);
                    }
                }
            }
        }

        return min_deletions;
    }
};