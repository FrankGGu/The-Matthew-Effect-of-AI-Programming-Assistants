#include <string>
#include <vector>
#include <cmath>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long countCompleteSubstrings(std::string word, int k) {
        long long total_complete_substrings = 0;
        int n = word.length();

        int current_segment_start = 0;
        for (int i = 1; i <= n; ++i) {
            // Check for segment boundary or end of word
            // A segment boundary occurs if adjacent characters differ by more than k
            if (i == n || std::abs(word[i] - word[i-1]) > k) {
                // Process the current segment: word[current_segment_start ... i-1]
                std::string segment = word.substr(current_segment_start, i - current_segment_start);

                // Iterate through all possible number of unique characters (U_val from 1 to 26)
                for (int U_val = 1; U_val <= 26; ++U_val) {
                    std::vector<int> counts(26, 0); // Character counts in the current sliding window [left, right]
                    // freq_counts[f] stores how many characters appear 'f' times in the current window
                    // Max frequency any character can have is segment.length(), so size segment.length() + 1
                    std::vector<int> freq_counts(segment.length() + 1, 0); 

                    int unique_chars = 0; // Number of unique characters in the current window
                    // distinct_freq_types: Number of distinct frequency values present among characters with count > 0.
                    // E.g., if chars appear 2,2,3 times, this is 2 (for frequencies 2 and 3).
                    int distinct_freq_types = 0; 

                    int left = 0;
                    for (int right = 0; right < segment.length(); ++right) {
                        // Add segment[right] to the window
                        int char_idx = segment[right] - 'a';

                        // If char_idx was already present, update its old frequency count in freq_counts
                        if (counts[char_idx] > 0) {
                            freq_counts[counts[char_idx]]--;
                            if (freq_counts[counts[char_idx]] == 0) {
                                distinct_freq_types--; // This frequency value is no longer present
                            }
                        }

                        // Increment count for char_idx
                        counts[char_idx]++;
                        if (counts[char_idx] == 1) { // First occurrence of this char in the window
                            unique_chars++;
                        }

                        // Update freq_counts for the new frequency of char_idx
                        freq_counts[counts[char_idx]]++;
                        if (freq_counts[counts[char_idx]] == 1) {
                            distinct_freq_types++; // This frequency value is now present
                        }

                        // Shrink window from left if unique_chars exceeds U_val
                        while (unique_chars > U_val) {
                            int char_idx_left = segment[left] - 'a';

                            // Update freq_counts for the old frequency of char_idx_left
                            freq_counts[counts[char_idx_left]]--;
                            if (freq_counts[counts[char_idx_left]] == 0) {
                                distinct_freq_types--; // This frequency value is no longer present
                            }

                            // Decrement count for char_idx_left
                            counts[char_idx_left]--;
                            if (counts[char_idx_left] == 0) { // Char removed entirely from window
                                unique_chars--;
                            } else { // Char still in window, but its count decreased
                                // Update freq_counts for the new (decreased) frequency of char_idx_left
                                freq_counts[counts[char_idx_left]]++;
                                if (freq_counts[counts[char_idx_left]] == 1) {
                                    distinct_freq_types++; // This frequency value is now present
                                }
                            }
                            left++;
                        }

                        // At this point, unique_chars <= U_val.
                        // If unique_chars == U_val, check if it's a complete substring.
                        // A substring is complete if:
                        // 1. It has exactly U_val unique characters. (Ensured by `unique_chars == U_val`)
                        // 2. All characters in the substring appear the same number of times.
                        //    This implies distinct_freq_types must be 1 (meaning only one frequency value is present for all unique characters).
                        // 3. The length of the substring (right - left + 1) must be U_val * common_frequency.
                        if (unique_chars == U_val && distinct_freq_types == 1) {
                            // Find the common frequency. Since distinct_freq_types is 1,
                            // any character currently in the window will have this common frequency.
                            int common_freq = counts[segment[left] - 'a']; 
                            if ((right - left + 1) == U_val * common_freq) {
                                total_complete_substrings++;
                            }
                        }
                    }
                }
                current_segment_start = i;
            }
        }

        return total_complete_substrings;
    }
};