class Solution {
    public int findMinimumOperations(String s1, String s2, String s3) {
        int n1 = s1.length();
        int n2 = s2.length();
        int n3 = s3.length();

        int minLen = Math.min(n1, Math.min(n2, n3));
        int commonPrefixLen = 0;

        for (int i = 0; i < minLen; i++) {
            if (s1.charAt(i) == s2.charAt(i) && s2.charAt(i) == s3.charAt(i)) {
                commonPrefixLen++;
            } else {
                break;
            }
        }

        if (commonPrefixLen == 0) {
            return -1;
        }

        return n1 + n2 + n3 - 3 * commonPrefixLen;
    }
}