#include <string>
#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
private:
    // Helper function to find the shortest string that contains both a and b.
    // If one string is already a substring of the other, return the longer one.
    // Otherwise, find the maximum overlap and merge them.
    std::string merge(const std::string& a, const std::string& b) {
        // Case 1: b is a substring of a
        if (a.find(b) != std::string::npos) {
            return a;
        }
        // Case 2: a is a substring of b
        if (b.find(a) != std::string::npos) {
            return b;
        }

        // Case 3: Find maximum overlap
        int max_overlap = 0;
        // Iterate from k=1 up to min(a.length(), b.length())
        // We are looking for a suffix of 'a' that is a prefix of 'b'
        // The largest k gives the maximum overlap
        for (int k = 1; k <= std::min(a.length(), b.length()); ++k) {
            if (a.substr(a.length() - k) == b.substr(0, k)) {
                max_overlap = k;
            }
        }

        // Merge a and b using the maximum overlap
        return a + b.substr(max_overlap);
    }

public:
    std::string shortestStringThatContainsThreeStrings(std::string s1, std::string s2, std::string s3) {
        std::vector<std::string> s = {s1, s2, s3};
        std::string ans = s1 + s2 + s3; // Initialize with a valid (though likely not optimal) candidate

        // Permutations of indices {0, 1, 2}
        std::vector<int> p = {0, 1, 2};

        // Iterate through all 3! = 6 permutations
        do {
            // Merge the first two strings in the current permutation
            std::string temp = merge(s[p[0]], s[p[1]]);
            // Merge the result with the third string
            temp = merge(temp, s[p[2]]);

            // Compare with the current best answer
            if (temp.length() < ans.length()) {
                ans = temp;
            } else if (temp.length() == ans.length()) {
                // If lengths are equal, choose the lexicographically smallest
                if (temp < ans) {
                    ans = temp;
                }
            }
        } while (std::next_permutation(p.begin(), p.end()));

        return ans;
    }
};