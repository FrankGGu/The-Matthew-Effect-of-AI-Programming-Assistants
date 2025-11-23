public class Solution {
    public boolean canConstructPalindromeFromSubstrings(String s, int n) {
        int[] count = new int[32];
        for (char c : s.toCharArray()) {
            count[c - '0']++;
        }
        int oddCount = 0;
        for (int i = 0; i < 32; i++) {
            if (count[i] % 2 != 0) {
                oddCount++;
            }
        }
        return oddCount <= 1;
    }

    public boolean queryString(String s, int n) {
        for (int i = 1; i <= n; i++) {
            String binary = Integer.toBinaryString(i);
            if (!s.contains(binary)) {
                return false;
            }
        }
        return true;
    }
}