class Solution {
    public int findTheOccurrenceOfFirstAlmostEqualSubstring(String s1, String s2, int k) {
        int n1 = s1.length();
        int n2 = s2.length();

        if (n2 == 0) {
            return 0;
        }
        if (n1 < n2) {
            return -1;
        }

        for (int i = 0; i <= n1 - n2; i++) {
            boolean isAlmostEqual = true;
            for (int j = 0; j < n2; j++) {
                if (Math.abs(s1.charAt(i + j) - s2.charAt(j)) > k) {
                    isAlmostEqual = false;
                    break;
                }
            }
            if (isAlmostEqual) {
                return i;
            }
        }

        return -1;
    }
}