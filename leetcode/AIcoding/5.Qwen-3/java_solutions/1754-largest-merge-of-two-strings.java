public class Solution {
    public String largestMerge(String s1, String s2) {
        int i = 0, j = 0;
        StringBuilder result = new StringBuilder();
        while (i < s1.length() && j < s2.length()) {
            if (s1.charAt(i) > s2.charAt(j)) {
                result.append(s1.charAt(i));
                i++;
            } else if (s1.charAt(i) < s2.charAt(j)) {
                result.append(s2.charAt(j));
                j++;
            } else {
                if (s1.substring(i).compareTo(s2.substring(j)) > 0) {
                    result.append(s1.charAt(i));
                    i++;
                } else {
                    result.append(s2.charAt(j));
                    j++;
                }
            }
        }
        while (i < s1.length()) {
            result.append(s1.charAt(i));
            i++;
        }
        while (j < s2.length()) {
            result.append(s2.charAt(j));
            j++;
        }
        return result.toString();
    }
}