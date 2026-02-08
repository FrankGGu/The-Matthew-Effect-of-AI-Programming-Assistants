class Solution {
    public int partitionString(String s, int k) {
        int count = 1;
        int currentVal = 0;
        boolean[] seen = new boolean[26];

        for (int i = 0; i < s.length(); i++) {
            int charVal = s.charAt(i) - 'a' + 1;
            if (seen[s.charAt(i) - 'a']) {
                count++;
                seen = new boolean[26];
                seen[s.charAt(i) - 'a'] = true;
            } else {
                seen[s.charAt(i) - 'a'] = true;
            }
        }

        return count;
    }
}