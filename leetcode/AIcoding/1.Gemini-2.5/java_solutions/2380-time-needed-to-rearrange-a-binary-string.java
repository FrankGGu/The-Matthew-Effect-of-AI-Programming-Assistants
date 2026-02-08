class Solution {
    public int secondsToRemoveOccurrences(String s) {
        int zeros = 0;
        int time = 0;
        for (char c : s.toCharArray()) {
            if (c == '0') {
                zeros++;
            } else { // c == '1'
                if (zeros > 0) {
                    // When a '1' is encountered, and there are '0's to its left (zeros > 0),
                    // these '0's need to move right past this '1'.
                    // The 'time' variable accumulates the maximum time required.
                    // 'time + 1' accounts for the current second of operations.
                    // 'zeros + time' accounts for the total time needed for all 'zeros'
                    // encountered so far to move past the current '1', considering
                    // the time already elapsed.
                    time = Math.max(time + 1, zeros + time);
                }
            }
        }
        return time;
    }
}