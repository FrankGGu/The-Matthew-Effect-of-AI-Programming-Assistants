public class Solution {
    public String removeAdjacent(String s) {
        StringBuilder result = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (result.length() > 0 && result.charAt(result.length() - 1) == c) {
                result.setLength(result.length() - 1);
            } else {
                result.append(c);
            }
        }
        return result.toString();
    }
}