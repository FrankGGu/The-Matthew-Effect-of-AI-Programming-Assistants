class Solution {
    public int countPalindromicSubsequence(String s) {
        int count = 0;
        for (char c = 'a'; c <= 'z'; c++) {
            int first = -1, last = -1;
            for (int i = 0; i < s.length(); i++) {
                if (s.charAt(i) == c) {
                    if (first == -1) {
                        first = i;
                    }
                    last = i;
                }
            }
            if (first != -1 && last != -1 && first < last) {
                java.util.HashSet<Character> uniqueMiddle = new java.util.HashSet<>();
                for (int i = first + 1; i < last; i++) {
                    uniqueMiddle.add(s.charAt(i));
                }
                count += uniqueMiddle.size();
            }
        }
        return count;
    }
}