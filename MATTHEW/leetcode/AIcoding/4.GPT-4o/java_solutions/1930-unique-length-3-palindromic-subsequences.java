import java.util.HashSet;

class Solution {
    public int countPalindromicSubsequences(String s) {
        HashSet<String> uniquePalindromes = new HashSet<>();
        int n = s.length();

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (s.charAt(i) == s.charAt(j)) {
                    String palindrome = "" + s.charAt(i) + s.charAt(j);
                    for (int k = 0; k < n; k++) {
                        if (k != i && k != j && s.charAt(k) == s.charAt(i)) {
                            uniquePalindromes.add(s.charAt(i) + palindrome);
                        }
                    }
                }
            }
        }

        return uniquePalindromes.size();
    }
}