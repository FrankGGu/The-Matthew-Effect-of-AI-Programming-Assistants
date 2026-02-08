class Solution {
    public int longestPalindrome(String s) {
        int[] charCounts = new int[52];
        for (char c : s.toCharArray()) {
            if (c >= 'a' && c <= 'z') {
                charCounts[c - 'a']++;
            } else {
                charCounts[c - 'A' + 26]++;
            }
        }

        int length = 0;
        boolean hasOdd = false;
        for (int count : charCounts) {
            if (count % 2 == 0) {
                length += count;
            } else {
                length += count - 1;
                hasOdd = true;
            }
        }

        if (hasOdd) {
            length++;
        }

        return length;
    }
}