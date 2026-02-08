class Solution {
    public int minMovesToMakePalindrome(String s) {
        int n = s.length();
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        int moves = 0;
        int oddCount = 0;

        for (int c : count) {
            if (c % 2 == 1) oddCount++;
            moves += c / 2;
        }

        moves = moves - (oddCount / 2);
        return moves;
    }
}