public class Solution {
    public String truncateSentence(String s, int k) {
        StringBuilder result = new StringBuilder();
        int count = 0;
        for (char c : s.toCharArray()) {
            if (count == k) break;
            result.append(c);
            if (c == ' ') count++;
        }
        return result.toString();
    }
}