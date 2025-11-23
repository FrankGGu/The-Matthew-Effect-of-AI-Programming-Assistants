public class Solution {
    public String findLexicographicalLargestString(String[] box) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < box.length; i++) {
            sb.append(box[i]);
        }
        char[] chars = sb.toString().toCharArray();
        java.util.Arrays.sort(chars, (a, b) -> b - a);
        return new String(chars);
    }
}