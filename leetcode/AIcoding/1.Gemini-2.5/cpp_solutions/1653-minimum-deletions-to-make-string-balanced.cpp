#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    int minimumDeletions(std::string s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        int count_a_total = 0;
        for (char c : s) {
            if (c == 'a') {
                count_a_total++;
            }
        }

        // min_deletions is initialized to the cost of making the entire string 'b's.
        // This corresponds to a split point at index 0 (k=0), where all characters s[0...n-1]
        // are considered part of the 'b' section, so all 'a's must be deleted.
        int min_deletions = count_a_total; 

        // count_b_left: number of 'b's encountered so far (in s[0...i-1]) that need to be deleted
        //                if this segment is to be all 'a's.
        int count_b_left = 0; 

        // count_a_right: number of 'a's remaining in the suffix (s[i...n-1]) that need to be deleted
        //                 if this segment is to be all 'b's.
        int count_a_right = count_a_total; 

        // Iterate through all possible split points.
        // The loop variable 'i' represents the current character being processed.
        // The split point 'k' is effectively 'i+1', meaning s[0...i] are considered
        // part of the left 'a' section, and s[i+1...n-1] are part of the right 'b' section.
        for (int i = 0; i < n; ++i) {
            if (s[i] == 'a') {
                // If s[i] is 'a', it's now on the left side of the split,
                // so it no longer contributes to 'a's that need to be deleted from the right side.
                count_a_right--;
            } else { // s[i] == 'b'
                // If s[i] is 'b', it's now on the left side of the split,
                // so it's a 'b' that needs to be deleted to make the left side all 'a's.
                count_b_left++;
            }
            // The current number of deletions for this split point (after s[i])
            // is the sum of 'b's to delete on the left and 'a's to delete on the right.
            min_deletions = std::min(min_deletions, count_b_left + count_a_right);
        }

        return min_deletions;
    }
};