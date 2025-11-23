#include <string>
#include <vector>
#include <algorithm>
#include <map>
#include <functional>

class Solution {
public:
    // Precomputed next_occurrence[char_idx][start_idx] stores the smallest index >= start_idx
    // where char_idx ('a' to 'z') appears in s.
    // If not found, it's -1.
    std::vector<std::vector<int>> next_occurrence;
    const std::string* s_ptr; // Pointer to the original string s
    int K; // Global k

    // Check if string t repeated K times is a subsequence of s
    bool check(const std::string& t) {
        int current_s_idx = 0; // Current position in s to start searching from
        for (int rep = 0; rep < K; ++rep) {
            for (char tc : t) {
                // Find tc starting from current_s_idx
                current_s_idx = next_occurrence[tc - 'a'][current_s_idx];
                if (current_s_idx == -1) {
                    return false; // Character not found
                }
                current_s_idx++; // Move past the found character for the next search
            }
        }
        return true;
    }

    // Backtracking function to build the lexicographically largest t of length L
    // s_freq: frequency of each character in the original string s
    // current_t: the string t being built
    // t_char_counts: frequency of characters in current_t
    // L: target length of t
    // idx: current index in t being built
    std::string build_t_greedy(int L, const std::vector<int>& s_freq) {
        std::string current_t = "";
        std::vector<int> t_char_counts(26, 0); // Frequency of characters in current_t

        std::function<bool(int)> backtrack = 
            [&](int idx) -> bool {
            if (idx == L) {
                return check(current_t);
            }

            // Try characters from 'z' down to 'a' for lexicographical largest
            for (char c_val = 'z'; c_val >= 'a'; --c_val) {
                int c_idx = c_val - 'a';

                // Pruning: check if adding c_val is valid based on s_freq and K
                // If current_t is a prefix of t, and we add c_val, then c_val will appear
                // (t_char_counts[c_idx] + 1) times in t.
                // Thus, in t repeated K times, c_val will appear K * (t_char_counts[c_idx] + 1) times.
                // This must be less than or equal to its total occurrences in s.
                if (s_freq[c_idx] >= K * (t_char_counts[c_idx] + 1)) {
                    t_char_counts[c_idx]++;
                    current_t.push_back(c_val);

                    if (backtrack(idx + 1)) {
                        return true; // Found a valid t, propagate up
                    }

                    current_t.pop_back(); // Backtrack
                    t_char_counts[c_idx]--; // Backtrack char count
                }
            }
            return false; // No character could form a valid t of length L
        };

        if (backtrack(0)) {
            return current_t;
        } else {
            return "";
        }
    }

    std::string longestSubsequenceRepeatedK(std::string s, int k) {
        s_ptr = &s;
        K = k;

        int n = s.length();

        // 1. Precompute character frequencies in s
        std::vector<int> s_freq(26, 0);
        for (char c : s) {
            s_freq[c - 'a']++;
        }

        // 2. Precompute next_occurrence table
        // next_occurrence[c][i] stores the index of the first occurrence of char 'a'+c at or after index i.
        // If no such occurrence, it's -1.
        next_occurrence.assign(26, std::vector<int>(n + 1, -1));
        for (int c = 0; c < 26; ++c) {
            for (int i = n - 1; i >= 0; --i) {
                next_occurrence[c][i] = next_occurrence[c][i+1]; // Inherit from right
                if (s[i] - 'a' == c) {
                    next_occurrence[c][i] = i; // Update if current character matches
                }
            }
        }
        // next_occurrence[c][n] is already -1, which is correct for searches starting at or after n.

        std::string result = "";
        // Iterate on possible lengths of t, from max_len down to 0
        // Max possible length of t is n / k
        for (int L = n / k; L >= 0; --L) {
            std::string current_ans_for_L = build_t_greedy(L, s_freq);
            if (!current_ans_for_L.empty()) {
                result = current_ans_for_L;
                break; // Found the longest possible t, so we are done
            }
        }

        return result;
    }
};