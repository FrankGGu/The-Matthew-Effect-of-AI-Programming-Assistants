class Solution {
    public String lastSubstring(String s) {
        int n = s.length();
        int i = 0, j = 1;

        while (j < n) {
            int k = 0;
            // Find the length of the common prefix between s[i...] and s[j...]
            while (j + k < n && s.charAt(i + k) == s.charAt(j + k)) {
                k++;
            }

            if (j + k == n) { 
                // If s[j...] is a prefix of s[i...] (or they are identical),
                // then s[i...] is the lexicographically largest among candidates starting at i and j.
                // Since j has reached the end, no further candidate starting at or after j can be longer or larger.
                // So, i is the final answer.
                break;
            }

            if (s.charAt(i + k) < s.charAt(j + k)) {
                // s[j...] is lexicographically larger than s[i...].
                // This means s[i...] cannot be the answer.
                // The new best candidate starts at j.
                // We can discard all positions from i to j+k-1.
                i = j;
                j = i + 1; // Start comparing the new 'i' with the next position.
            } else { // s.charAt(i + k) > s.charAt(j + k)
                // s[i...] is lexicographically larger than s[j...].
                // This means s[j...] cannot be the answer.
                // We can discard all positions from j to j+k.
                // The next candidate for 'j' must start after j+k.
                j = j + k + 1;
            }
        }

        return s.substring(i);
    }
}