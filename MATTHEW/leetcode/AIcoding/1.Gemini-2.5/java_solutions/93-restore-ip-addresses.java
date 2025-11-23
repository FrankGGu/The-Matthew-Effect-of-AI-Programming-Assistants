import java.util.ArrayList;
import java.util.List;

class Solution {

    public List<String> restoreIpAddresses(String s) {
        List<String> result = new ArrayList<>();
        // An IP address has 4 parts, each 1-3 digits.
        // Minimum length for a valid IP string (e.g., "0000" -> "0.0.0.0") is 4.
        // Maximum length for a valid IP string (e.g., "255255255255") is 12.
        if (s == null || s.length() < 4 || s.length() > 12) {
            return result;
        }

        backtrack(s, 0, new ArrayList<>(), result);
        return result;
    }

    private void backtrack(String s, int start, List<String> currentIpParts, List<String> result) {
        // Base case: If we have formed 4 parts
        if (currentIpParts.size() == 4) {
            // If all characters from s have been used, it's a valid IP
            if (start == s.length()) {
                result.add(String.join(".", currentIpParts));
            }
            return; // Whether valid or not, we have 4 parts, so this path ends
        }

        // Iterate to form the next segment (1, 2, or 3 digits long)
        for (int len = 1; len <= 3; len++) {
            int endIndex = start + len;

            // Check if the segment goes out of bounds of the string s
            if (endIndex > s.length()) {
                break; // Cannot form a segment of this length
            }

            String segment = s.substring(start, endIndex);

            // Check if the segment is a valid IP part (0-255, no leading zeros except for "0")
            if (!isValidSegment(segment)) {
                // If "01" is invalid, "012" will also be invalid. So no need to try longer segments starting with '0'.
                break; 
            }

            currentIpParts.add(segment); // Choose
            backtrack(s, endIndex, currentIpParts, result); // Explore
            currentIpParts.remove(currentIpParts.size() - 1); // Unchoose (backtrack)
        }
    }

    private boolean isValidSegment(String s) {
        // Length check
        if (s.length() == 0 || s.length() > 3) {
            return false;
        }
        // Leading zero check: "01" is invalid, but "0" is valid.
        if (s.length() > 1 && s.charAt(0) == '0') {
            return false;
        }
        // Value range check
        int num = Integer.parseInt(s);
        return num >= 0 && num <= 255;
    }
}