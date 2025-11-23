#include <string.h> // For strlen, memset
#include <stdlib.h> // For abs

static int freq_map_global[26];
static int freq_count_map_global[100001]; // Max segment_len + 1

static long long solve_segment(char * segment_ptr, int segment_len);

long long countCompleteSubstrings(char * s, int k) {
    int n = strlen(s);
    long long total_ans = 0;

    // Split the string into segments based on condition 2:
    // For any two adjacent characters s[p] and s[p+1], abs(s[p] - s[p+1]) <= k.
    // A new segment starts if this condition is violated.
    int current_segment_start = 0;
    for (int i = 0; i < n; ++i) {
        if (i > 0 && abs(s[i] - s[i-1]) > k) {
            // Process the segment s[current_segment_start ... i-1]
            total_ans += solve_segment(s + current_segment_start, i - current_segment_start);
            current_segment_start = i;
        }
    }
    // Process the last segment
    total_ans += solve_segment(s + current_segment_start, n - current_segment_start);

    return total_ans;
}

static long long solve_segment(char * segment_ptr, int segment_len) {
    long long ans = 0;

    if (segment_len == 0) {
        return 0;
    }

    // Iterate through all possible number of distinct characters, C.
    // C can be from 1 to 26 (max alphabet size).
    for (int C = 1; C <= 26; ++C) {
        // Reset frequency maps for each C.
        memset(freq_map_global, 0, sizeof(freq_map_global));
        // Only clear the part of freq_count_map_global that might be used, up to segment_len + 1.
        memset(freq_count_map_global, 0, (segment_len + 1) * sizeof(int));

        int distinct_chars = 0; // Number of distinct characters in the current sliding window
        int left = 0;           // Left pointer of the sliding window

        // Right pointer of the sliding window
        for (int right = 0; right < segment_len; ++right) {
            int char_idx = segment_ptr[right] - 'a';

            // Update freq_map_global and freq_count_map_global when adding segment_ptr[right]
            if (freq_map_global[char_idx] > 0) {
                // If character was already present, decrement count for its old frequency
                freq_count_map_global[freq_map_global[char_idx]]--;
            } else {
                // If character is new, increment distinct_chars count
                distinct_chars++;
            }
            // Increment character's frequency and update count for its new frequency
            freq_map_global[char_idx]++;
            freq_count_map_global[freq_map_global[char_idx]]++;

            // Shrink window from the left if distinct_chars exceeds C
            while (distinct_chars > C) {
                int left_char_idx = segment_ptr[left] - 'a';

                // Decrement count for the character's current frequency
                freq_count_map_global[freq_map_global[left_char_idx]]--;
                // Decrement character's frequency
                freq_map_global[left_char_idx]--;

                if (freq_map_global[left_char_idx] > 0) {
                    // If character is still present, increment count for its new (lower) frequency
                    freq_count_map_global[freq_map_global[left_char_idx]]++;
                } else {
                    // If character is no longer present, decrement distinct_chars count
                    distinct_chars--;
                }
                left++; // Move left pointer to shrink window
            }

            // If distinct_chars is exactly C, check condition 1:
            // All C distinct characters must have the same frequency.
            // This implies the current window length must be a multiple of C,
            // and the frequency of each char must be (current_len / C).
            if (distinct_chars == C) {
                int current_len = right - left + 1;
                if (current_len % C == 0) {
                    int target_freq = current_len / C;
                    // target_freq must be > 0 because current_len >= C >= 1
                    // Check if exactly C characters have this target_freq
                    if (freq_count_map_global[target_freq] == C) {
                        ans++;
                    }
                }
            }
        }
    }
    return ans;
}