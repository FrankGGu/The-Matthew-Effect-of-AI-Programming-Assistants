#include <string>
#include <algorithm> // Required for std::min with an initializer list

class Solution {
public:
    int findMinimumOperations(std::string s1, std::string s2, std::string s3) {
        int len1 = s1.length();
        int len2 = s2.length();
        int len3 = s3.length();

        int min_len = std::min({len1, len2, len3});

        int lcp_len = 0; // Length of the longest common prefix
        for (int i = 0; i < min_len; ++i) {
            if (s1[i] == s2[i] && s1[i] == s3[i]) {
                lcp_len++;
            } else {
                break; // Mismatch found, LCP ends here
            }
        }

        // If no common prefix of length at least 1 is found, it's impossible to make them equal
        // to a non-empty string.
        if (lcp_len == 0) {
            return -1;
        } else {
            // Calculate operations: (original_length - LCP_length) for each string
            return (len1 - lcp_len) + (len2 - lcp_len) + (len3 - lcp_len);
        }
    }
};