public class Solution {
    public int countSubstringsDivisibleByLastDigit(String s) {
        int count = 0;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                String sub = s.substring(i, j);
                int lastDigit = Character.getNumericValue(sub.charAt(sub.length() - 1));
                if (lastDigit != 0 && Integer.parseInt(sub) % lastDigit == 0) {
                    count++;
                }
            }
        }
        return count;
    }
}