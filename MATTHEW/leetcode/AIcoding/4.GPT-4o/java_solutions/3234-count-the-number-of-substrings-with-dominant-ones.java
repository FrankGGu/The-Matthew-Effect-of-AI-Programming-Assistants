class Solution {
    public long countBinarySubstrings(String s) {
        int n = s.length();
        int[] groups = new int[n];
        int index = 0;

        for (int i = 0; i < n; i++) {
            if (i == 0 || s.charAt(i) != s.charAt(i - 1)) {
                index++;
            }
            groups[index - 1]++;
        }

        long count = 0;
        for (int i = 1; i < index; i++) {
            count += Math.min(groups[i - 1], groups[i]);
        }

        return count;
    }
}