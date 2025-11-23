#include <string>
#include <vector>
#include <algorithm> // For std::reverse

class Solution {
public:
    std::string shortestPalindrome(std::string s) {
        int n = s.length();
        if (n == 0) {
            return "";
        }

        std::string reversed_s = s;
        std::reverse(reversed_s.begin(), reversed_s.end());

        // Construct the KMP pattern string: s + '#' + reversed_s
        // The '#' character ensures that any match cannot cross the boundary,
        // so the longest proper prefix of temp that is also a suffix of temp
        // will correspond to the longest prefix of s that is also a suffix of reversed_s.
        // This is exactly the longest palindromic prefix of s.
        std::string temp = s + '#' + reversed_s;
        int temp_n = temp.length();

        // Compute the LPS (Longest Proper Prefix which is also Suffix) array for temp
        std::vector<int> pi(temp_n, 0);
        for (int i = 1; i < temp_n; ++i) {
            int j = pi[i - 1]; // Start with the LPS length of the previous prefix

            // While j > 0 and current characters don't match,
            // fall back using the LPS array
            while (j > 0 && temp[i] != temp[j]) {
                j = pi[j - 1];
            }

            // If characters match, increment j
            if (temp[i] == temp[j]) {
                j++;
            }

            pi[i] = j; // Store the new LPS length
        }

        // The last element of the pi array (pi[temp_n - 1]) gives the length
        // of the longest prefix of 's' that is also a suffix of 'reversed_s'.
        // This length corresponds to the longest palindromic prefix of 's'.
        int longest_palindromic_prefix_len = pi[temp_n - 1];

        // The characters to prepend are the suffix of 's' that is NOT part of
        // the longest palindromic prefix, reversed.
        std::string suffix_to_prepend = s.substr(longest_palindromic_prefix_len);
        std::reverse(suffix_to_prepend.begin(), suffix_to_prepend.end());

        // Concatenate the reversed suffix with the original string 's'
        return suffix_to_prepend + s;
    }
};