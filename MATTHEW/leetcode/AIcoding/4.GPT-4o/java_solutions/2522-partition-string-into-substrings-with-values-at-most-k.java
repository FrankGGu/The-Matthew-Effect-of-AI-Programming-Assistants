class Solution {
    public int partitionString(String s, int k) {
        boolean[] seen = new boolean[26];
        int count = 0;
        int value = 0;

        for (char c : s.toCharArray()) {
            int index = c - 'a';
            if (seen[index]) {
                count++;
                seen = new boolean[26];
                value = 0;
            }
            seen[index] = true;
            value += index + 1;
            if (value > k) {
                count++;
                seen = new boolean[26];
                value = 0;
                seen[index] = true;
                value += index + 1;
            }
        }

        return count + 1;
    }
}