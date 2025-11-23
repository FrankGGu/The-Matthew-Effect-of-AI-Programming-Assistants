#include <string>
#include <vector>

class Solution {
public:
    int numberOfSubstrings(std::string s) {
        int n = s.length();
        int left = 0;
        int ans = 0;
        std::vector<int> counts(3, 0); // counts for 'a', 'b', 'c'

        for (int right = 0; right < n; ++right) {
            counts[s[right] - 'a']++;

            // Shrink the window from the left as much as possible while
            // maintaining all three characters ('a', 'b', 'c') in the window s[left...right].
            while (counts[0] > 0 && counts[1] > 0 && counts[2] > 0) {
                // If the window s[left...right] contains all three characters,
                // it means that s[left] is the character that, if removed,
                // might make the window invalid (or just shorten it while keeping it valid).
                //
                // After this `while` loop, `left` will point to the first index such that
                // the window `s[left...right]` no longer contains all three characters.
                // This implies that `s[left-1...right]` *was* a valid window.
                //
                // Therefore, all substrings starting from index 0 up to `left-1`
                // and ending at `right` are valid.
                // The number of such starting positions (0, 1, ..., left-1) is `left`.
                //
                // We add `left` to our total count.
                // Then we remove s[left] and increment left to find the next minimal valid window.

                counts[s[left] - 'a']--;
                left++;
            }
            // After the while loop, `left` is the smallest index such that `s[left...right]`
            // does NOT contain all three characters.
            // This means that any substring starting at an index `k` where `k < left`
            // and ending at `right` *must* contain all three characters.
            // The number of such starting positions (0, 1, ..., left-1) is `left`.
            // We add this count to the total answer.
            ans += left;
        }
        return ans;
    }
};