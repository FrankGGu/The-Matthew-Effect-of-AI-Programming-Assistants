public class Solution {
    public int countVowels(String word) {
        int n = word.length();
        int result = 0;
        for (int i = 0; i < n; i++) {
            char c = word.charAt(i);
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                result += (i + 1) * (n - i);
            }
        }
        return result;
    }
}