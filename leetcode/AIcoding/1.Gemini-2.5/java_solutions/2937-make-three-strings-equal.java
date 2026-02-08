class Solution {
    public int findMaximumLength(String s1, String s2, String s3) {
        int n1 = s1.length();
        int n2 = s2.length();
        int n3 = s3.length();

        int minLen = Math.min(n1, Math.min(n2, n3));

        int commonLength = 0;
        for (int i = 0; i < minLen; i++) {
            if (s1.charAt(i) == s2.charAt(i) && s2.charAt(i) == s3.charAt(i)) {
                commonLength++;
            } else {
                break;
            }
        }
        return commonLength;
    }
}