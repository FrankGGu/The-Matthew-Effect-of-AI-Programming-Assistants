class Solution {
    public int numSteps(String s) {
        StringBuilder sb = new StringBuilder(s);
        int steps = 0;

        while (sb.length() > 1) {
            steps++;
            if (sb.charAt(sb.length() - 1) == '0') {
                // Number is even, divide by 2 (remove last '0')
                sb.deleteCharAt(sb.length() - 1);
            } else {
                // Number is odd, add 1
                // Find the rightmost '0' to flip to '1', and flip all '1's after it to '0's
                int i = sb.length() - 1;
                while (i >= 0 && sb.charAt(i) == '1') {
                    sb.setCharAt(i, '0');
                    i--;
                }
                if (i < 0) {
                    // All digits were '1's (e.g., "111"). Prepend '1'.
                    sb.insert(0, '1');
                } else {
                    // Found a '0', flip it to '1'
                    sb.setCharAt(i, '1');
                }
            }
        }
        return steps;
    }
}