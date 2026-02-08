public class Solution {
    public String splitString(String s, int k) {
        int n = s.length();
        int[] hash = new int[k];
        for (int i = 0; i < n; i++) {
            hash[i % k] += s.charAt(i);
        }
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < k; i++) {
            result.append((char) hash[i]);
        }
        return result.toString();
    }
}