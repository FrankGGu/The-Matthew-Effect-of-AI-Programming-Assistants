public class Solution {
    public String dynamicPassword(String s, int[] target) {
        StringBuilder result = new StringBuilder();
        for (int i : target) {
            result.append(s.charAt(i));
        }
        return result.toString();
    }
}