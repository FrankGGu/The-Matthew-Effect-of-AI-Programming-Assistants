class Solution {
    public boolean checkOnesSegment(String s) {
        int firstOneIdx = s.indexOf('1');

        // If no '1's are found in the string, it has zero segments of ones, which satisfies "at most one segment".
        if (firstOneIdx == -1) {
            return true;
        }

        int lastOneIdx = s.lastIndexOf('1');

        // Iterate from the first '1' to the last '1'.
        // If any '0' is encountered within this range, it means there are at least two segments of '1's
        // separated by '0's, or a '0' breaking a single segment of '1's into multiple.
        for (int i = firstOneIdx; i <= lastOneIdx; i++) {
            if (s.charAt(i) == '0') {
                return false;
            }
        }

        // If the loop completes without finding any '0's between the first and last '1',
        // it means all characters from the first '1' to the last '1' are '1's.
        // This implies there is at most one contiguous segment of '1's.
        return true;
    }
}