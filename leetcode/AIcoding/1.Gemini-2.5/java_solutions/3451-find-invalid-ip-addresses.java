import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<String> result;
    private String s;

    public List<String> restoreIpAddresses(String s) {
        result = new ArrayList<>();
        this.s = s;

        // An IP address has 4 segments, each 1-3 digits long.
        // So, minimum length is 4 (e.g., "1.1.1.1") and maximum length is 12 (e.g., "255.255.255.255").
        if (s.length() < 4 || s.length() > 12) {
            return result;
        }

        backtrack(0, 0, new StringBuilder());
        return result;
    }

    private void backtrack(int index, int segmentCount, StringBuilder currentIp) {
        // Base case 1: Found 4 segments
        if (segmentCount == 4) {
            // If all characters from the original string are used, it's a valid IP.
            if (index == s.length()) {
                result.add(currentIp.toString());
            }
            return;
        }

        // Base case 2: Ran out of characters before forming 4 segments
        if (index == s.length()) {
            return;
        }

        // Try to form the next segment (1 to 3 digits long)
        for (int i = 1; i <= 3; i++) {
            // Check if there are enough characters left to form a segment of length 'i'
            if (index + i > s.length()) {
                break; // Not enough characters
            }

            String segment = s.substring(index, index + i);

            // Validate the current segment
            if (!isValid(segment)) {
                // If the current segment is invalid (e.g., "01" or "300"),
                // any longer segment starting with it will also be invalid.
                // So, we can prune this branch.
                break;
            }

            // Record current length of StringBuilder to backtrack later
            int originalLen = currentIp.length();

            currentIp.append(segment);
            // Append a dot if it's not the last segment
            if (segmentCount < 3) {
                currentIp.append('.');
            }

            // Recurse for the next segment
            backtrack(index + i, segmentCount + 1, currentIp);

            // Backtrack: remove the appended segment and dot
            currentIp.setLength(originalLen);
        }
    }

    private boolean isValid(String segment) {
        // Segment length check (should be 1 to 3, already handled by loop, but good for robustness)
        if (segment.length() == 0 || segment.length() > 3) {
            return false;
        }

        // Leading zero check: "01" is invalid, but "0" is valid
        if (segment.length() > 1 && segment.charAt(0) == '0') {
            return false;
        }

        // Value range check: 0 to 255
        int num = Integer.parseInt(segment);
        return num >= 0 && num <= 255;
    }
}