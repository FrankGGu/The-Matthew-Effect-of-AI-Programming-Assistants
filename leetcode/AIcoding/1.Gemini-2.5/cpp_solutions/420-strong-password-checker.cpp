#include <string>
#include <vector>
#include <algorithm> // For std::max, std::min
#include <cctype>    // For std::islower, std::isupper, std::isdigit

class Solution {
public:
    int strongPasswordChecker(std::string s) {
        int n = s.length();

        // 1. Check for missing character types
        bool has_lower = false;
        bool has_upper = false;
        bool has_digit = false;
        for (char c : s) {
            if (std::islower(c)) {
                has_lower = true;
            } else if (std::isupper(c)) {
                has_upper = true;
            } else if (std::isdigit(c)) {
                has_digit = true;
            }
        }
        int missing_types = (!has_lower) + (!has_upper) + (!has_digit);

        // 2. Find repeating character groups
        // Store the lengths of repeating sequences of 3 or more
        std::vector<int> repeat_lengths;
        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && s[j] == s[i]) {
                j++;
            }
            int len = j - i;
            if (len >= 3) {
                repeat_lengths.push_back(len);
            }
            i = j;
        }

        // Calculate initial replacements needed for repeating sequences
        // and categorize them by length % 3
        int total_replacements = 0;
        int cnt_rem_0 = 0; // Groups with length % 3 == 0 (e.g., 3, 6, 9...)
        int cnt_rem_1 = 0; // Groups with length % 3 == 1 (e.g., 4, 7, 10...)
        int cnt_rem_2 = 0; // Groups with length % 3 == 2 (e.g., 5, 8, 11...)

        for (int len : repeat_lengths) {
            total_replacements += len / 3;
            if (len % 3 == 0) {
                cnt_rem_0++;
            } else if (len % 3 == 1) {
                cnt_rem_1++;
            } else { // len % 3 == 2
                cnt_rem_2++;
            }
        }

        // 3. Calculate minimum changes based on password length
        if (n < 6) {
            // Need insertions to reach length 6.
            // These insertions can also fix missing types.
            return std::max(missing_types, 6 - n);
        } else if (n <= 20) {
            // Length is good. Only need to fix missing types and repeating sequences.
            // Replacements can fix both.
            return std::max(missing_types, total_replacements);
        } else { // n > 20
            // Need deletions to reach length 20.
            int deletions = n - 20;
            int ans = deletions; // Deletions are always counted.

            // Use deletions to reduce total_replacements as efficiently as possible.
            // Prioritize groups with length % 3 == 0 (1 deletion saves 1 replacement)
            int can_save = std::min(deletions, cnt_rem_0);
            deletions -= can_save;
            total_replacements -= can_save;

            // Prioritize groups with length % 3 == 1 (2 deletions save 1 replacement)
            can_save = std::min(deletions / 2, cnt_rem_1);
            deletions -= can_save * 2;
            total_replacements -= can_save;

            // Prioritize groups with length % 3 == 2 (3 deletions save 1 replacement)
            can_save = std::min(deletions / 3, cnt_rem_2);
            deletions -= can_save * 3;
            total_replacements -= can_save;

            // Any remaining deletions reduce total_replacements by 1 each (less efficiently)
            total_replacements -= deletions;
            total_replacements = std::max(0, total_replacements);

            // Add the maximum of remaining missing types or remaining replacements needed
            ans += std::max(missing_types, total_replacements);
            return ans;
        }
    }
};