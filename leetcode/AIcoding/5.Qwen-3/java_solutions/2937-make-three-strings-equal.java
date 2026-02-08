public class Solution {
    public int minChanges(String s1, String s2, String s3) {
        int changes = 0;
        for (int i = 0; i < s1.length(); i++) {
            char c1 = s1.charAt(i);
            char c2 = s2.charAt(i);
            char c3 = s3.charAt(i);
            if (c1 != c2 || c1 != c3) {
                changes++;
            }
        }
        return changes;
    }
}