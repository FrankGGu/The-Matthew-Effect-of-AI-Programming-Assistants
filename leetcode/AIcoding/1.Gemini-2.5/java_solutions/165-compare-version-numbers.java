class Solution {
    public int compareVersion(String version1, String version2) {
        String[] revisions1 = version1.split("\\.");
        String[] revisions2 = version2.split("\\.");

        int len1 = revisions1.length;
        int len2 = revisions2.length;

        int maxLength = Math.max(len1, len2);

        for (int i = 0; i < maxLength; i++) {
            int num1 = 0;
            if (i < len1) {
                num1 = Integer.parseInt(revisions1[i]);
            }

            int num2 = 0;
            if (i < len2) {
                num2 = Integer.parseInt(revisions2[i]);
            }

            if (num1 < num2) {
                return -1;
            } else if (num1 > num2) {
                return 1;
            }
        }

        return 0;
    }
}