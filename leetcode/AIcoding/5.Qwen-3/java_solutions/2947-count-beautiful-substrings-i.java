public class Solution {
    public int countBeautifulSubstrings(String s, int k) {
        int count = 0;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                String sub = s.substring(i, j);
                if (sub.length() % 2 == 0) {
                    int vowels = 0;
                    for (char c : sub.toCharArray()) {
                        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                            vowels++;
                        }
                    }
                    if (vowels == sub.length() / 2) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}