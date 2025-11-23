class Solution {
    public int numberOfSubstrings(String s) {
        int n = s.length();
        int count = 0;
        int left = 0;
        int[] freq = new int[3]; // Frequencies for 'a', 'b', 'c'

        for (int right = 0; right < n; right++) {
            freq[s.charAt(right) - 'a']++;

            // While the current window s[left...right] contains all three characters
            while (freq[0] > 0 && freq[1] > 0 && freq[2] > 0) {
                // If s[left...right] is a valid substring, then any substring
                // starting at 'left' and ending at 'right' or later (up to n-1)
                // will also be valid. The number of such substrings is (n - right).
                count += (n - right);

                // Shrink the window from the left
                freq[s.charAt(left) - 'a']--;
                left++;
            }
        }

        return count;
    }
}