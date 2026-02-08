public class Solution {
    public String removeOccurrences(String s, String part) {
        StringBuilder sb = new StringBuilder(s);
        int partLength = part.length();
        int index;
        while ((index = sb.toString().indexOf(part)) != -1) {
            sb.delete(index, index + partLength);
        }
        return sb.toString();
    }
}