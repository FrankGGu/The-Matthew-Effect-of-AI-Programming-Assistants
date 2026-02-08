public class Solution {
    public int countBeautifulSubstrings(String s, int k) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; i++) {
            int vowels = 0;
            for (int j = i; j < n; j++) {
                if (s.charAt(j) == 'a' || s.charAt(j) == 'e' || s.charAt(j) == 'i' || s.charAt(j) == 'o' || s.charAt(j) == 'u') {
                    vowels++;
                }
                if ((j - i + 1) % k == 0 && vowels * 2 == j - i + 1) {
                    count++;
                }
            }
        }
        return count;
    }
}