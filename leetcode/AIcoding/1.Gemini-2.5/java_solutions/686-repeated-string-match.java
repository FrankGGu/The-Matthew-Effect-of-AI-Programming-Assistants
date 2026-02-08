class Solution {
    public int repeatedStringMatch(String a, String b) {
        StringBuilder sb = new StringBuilder();
        int count = 0;

        // Keep appending 'a' until sb is at least as long as 'b'
        // This ensures that if 'b' is a substring, it can potentially be fully contained.
        while (sb.length() < b.length()) {
            sb.append(a);
            count++;
        }

        // Check if 'b' is a substring of the current repeated 'a' sequence
        if (sb.toString().contains(b)) {
            return count;
        }

        // If not found, append 'a' one more time.
        // This is crucial for cases where 'b' spans across the boundary of the current 'sb' and the next 'a'.
        // For example, if a = "abcd" and b = "cdab", after one repetition sb = "abcd", b is not found.
        // After appending 'a' one more time, sb = "abcdabcd", and b ("cdab") is found.
        // The maximum length 'b' can span is roughly (length of a) + (length of b) + (length of a).
        // The current sb.length() is approximately b.length() + a.length().
        // Appending one more 'a' makes sb.length() approximately b.length() + 2*a.length(),
        // which covers all possible starting positions of 'b' within the repeated 'a' sequence.
        sb.append(a);
        count++;
        if (sb.toString().contains(b)) {
            return count;
        }

        // If 'b' is still not found after these checks, it's impossible to form 'b'
        // by repeating 'a'.
        return -1;
    }
}