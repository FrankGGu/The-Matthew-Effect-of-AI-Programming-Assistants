public class Solution {
    public boolean halvesAreAlike(String s) {
        int n = s.length();
        int half = n / 2;
        int count1 = 0, count2 = 0;
        for (int i = 0; i < half; i++) {
            char c = Character.toLowerCase(s.charAt(i));
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                count1++;
            }
        }
        for (int i = half; i < n; i++) {
            char c = Character.toLowerCase(s.charAt(i));
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                count2++;
            }
        }
        return count1 == count2;
    }
}