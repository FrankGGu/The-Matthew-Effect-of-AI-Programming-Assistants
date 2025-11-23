#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    long long count_at_most_k_consonants_and_all_vowels(const std::string& s, int k_limit) {
        if (k_limit < 0) {
            return 0;
        }

        int n = s.length();
        long long total_valid_substrings = 0;

        std::unordered_map<char, int> vm;
        vm['a'] = 0;
        vm['e'] = 1;
        vm['i'] = 2;
        vm['o'] = 3;
        vm['u'] = 4;
        const int TARGET_MASK = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4); // 0b11111 = 31

        int left_consonant = 0;
        int current_consonant_count = 0;

        int left_vowel = 0;
        std::vector<int> vowel_freq_vowel_window(5, 0);
        int current_vowel_mask_vowel_window = 0;

        for (int right = 0; right < n; ++right) {
            // --- Update for `left_consonant` window (s[left_consonant...right]) ---
            if (!vm.count(s[right])) { // If s[right] is a consonant
                current_consonant_count++;
            }

            while (current_consonant_count > k_limit) {
                if (!vm.count(s[left_consonant])) { // If s[left_consonant] is a consonant
                    current_consonant_count--;
                }
                left_consonant++;
            }

            // --- Update for `left_vowel` window (s[left_vowel...right]) ---
            if (vm.count(s[right])) { // If s[right] is a vowel
                int idx = vm[s[right]];
                vowel_freq_vowel_window[idx]++;
                current_vowel_mask_vowel_window |= (1 << idx);
            }

            while (current_vowel_mask_vowel_window == TARGET_MASK) {
                if (vm.count(s[left_vowel])) { // If s[left_vowel] is a vowel
                    int idx = vm[s[left_vowel]];
                    vowel_freq_vowel_window[idx]--;
                    if (vowel_freq_vowel_window[idx] == 0) {
                        current_vowel_mask_vowel_window &= ~(1 << idx);
                    }
                }
                left_vowel++;
            }

            // At this point:
            // 1. `s[left_consonant...right]` has `current_consonant_count <= k_limit`.
            // 2. `left_vowel` is the first index such that `s[left_vowel...right]` does NOT have all vowels.
            //    This implies that any substring `s[p...right]` where `p < left_vowel` contains all vowels.
            //    So, valid starting points `p` for the "all vowels" condition are `0, 1, ..., left_vowel - 1`.

            // Combining both conditions:
            // A valid substring `s[p...right]` must satisfy `p >= left_consonant` and `p < left_vowel`.
            // Thus, valid starting points `p` are in the range `[left_consonant, left_vowel - 1]`.
            // The number of such valid `p` is `(left_vowel - 1) - left_consonant + 1`, which simplifies to `left_vowel - left_consonant`.
            // We use `std::max(0, ...)` to handle cases where `left_vowel <= left_consonant`.
            total_valid_substrings += std::max(0, left_vowel - left_consonant);
        }

        return total_valid_substrings;
    }

    long long countSubstrings(std::string s, int k) {
        // The number of substrings with EXACTLY k consonants and all vowels
        // is (substrings with AT MOST k consonants and all vowels)
        // minus (substrings with AT MOST k-1 consonants and all vowels).
        long long count_at_most_k = count_at_most_k_consonants_and_all_vowels(s, k);
        long long count_at_most_k_minus_1 = count_at_most_k_consonants_and_all_vowels(s, k - 1);

        return count_at_most_k - count_at_most_k_minus_1;
    }
};