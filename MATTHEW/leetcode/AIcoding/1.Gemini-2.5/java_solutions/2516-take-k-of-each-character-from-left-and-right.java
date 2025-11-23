import java.util.Arrays;

class Solution {
    public int takeCharacters(String s, int k) {
        int n = s.length();
        int[] totalCounts = new int[3]; // 'a', 'b', 'c'

        // Step 1: Count total occurrences of 'a', 'b', 'c' in s
        for (char ch : s.toCharArray()) {
            totalCounts[ch - 'a']++;
        }

        // Step 2: If it's impossible to get k of any character (even by taking the whole string), return -1
        if (totalCounts[0] < k || totalCounts[1] < k || totalCounts[2] < k) {
            return -1;
        }

        // Step 3: Calculate target counts for the middle segment.
        // We want to find the longest middle segment s[left...right]
        // such that the characters *not* in this segment (prefix + suffix)
        // have at least k of each.
        // This means the middle segment can have at most (totalCount - k) of each character.
        int targetA = totalCounts[0] - k;
        int targetB = totalCounts[1] - k;
        int targetC = totalCounts[2] - k;

        int maxLenMiddle = 0;
        int[] currentCounts = new int[3]; // Counts in the current sliding window [left, right]
        int left = 0;

        // Step 4: Use a sliding window to find the longest valid middle segment.
        // A valid middle segment is one where the counts of 'a', 'b', 'c'
        // within the segment do not exceed their respective targets (targetA, targetB, targetC).
        for (int right = 0; right < n; right++) {
            char charRight = s.charAt(right);
            currentCounts[charRight - 'a']++;

            // Shrink the window from the left if any character count in the current window
            // exceeds its allowed target for the middle segment.
            while (currentCounts[0] > targetA || currentCounts[1] > targetB || currentCounts[2] > targetC) {
                char charLeft = s.charAt(left);
                currentCounts[charLeft - 'a']--;
                left++;
            }

            // The current window [left, right] is a valid middle segment.
            // Update the maximum length found so far.
            // If left > right, the window is empty, and its length (right - left + 1) would be 0 or negative.
            // maxLenMiddle will correctly handle this by taking Math.max(maxLenMiddle, 0).
            maxLenMiddle = Math.max(maxLenMiddle, right - left + 1);
        }

        // The minimum number of characters to take (from left and right)
        // is the total length of the string minus the maximum length of the middle segment we can remove.
        return n - maxLenMiddle;
    }
}