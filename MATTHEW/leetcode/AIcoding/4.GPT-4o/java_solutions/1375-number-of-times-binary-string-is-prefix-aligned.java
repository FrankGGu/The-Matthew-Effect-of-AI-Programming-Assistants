class Solution {
    public int countPrefixAlignments(String s) {
        int count = 0, ones = 0, zeros = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') {
                ones++;
            } else {
                zeros++;
            }
            if (ones == zeros) {
                count++;
            }
        }
        return count;
    }
}