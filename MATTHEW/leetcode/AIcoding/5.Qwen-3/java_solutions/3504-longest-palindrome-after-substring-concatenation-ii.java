public class Solution {
    public int longestPalindrome(String[] words) {
        java.util.Map<String, Integer> count = new java.util.HashMap<>();
        for (String word : words) {
            count.put(word, count.getOrDefault(word, 0) + 1);
        }
        int result = 0;
        boolean hasMiddle = false;
        for (String word : count.keySet()) {
            String reversed = new StringBuilder(word).reverse().toString();
            if (word.equals(reversed)) {
                int pairs = count.get(word) / 2;
                result += pairs * 2;
                if (count.get(word) % 2 == 1) {
                    hasMiddle = true;
                }
            } else {
                int pairs = Math.min(count.getOrDefault(word, 0), count.getOrDefault(reversed, 0));
                result += pairs * 2;
            }
        }
        if (hasMiddle) {
            result += 1;
        }
        return result;
    }
}