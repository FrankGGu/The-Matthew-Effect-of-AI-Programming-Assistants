class Solution {
    public long appealSum(String s) {
        long total = 0;
        int[] lastOccurrence = new int[26];
        Arrays.fill(lastOccurrence, -1);

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            total += (i - lastOccurrence[c - 'a']) * (s.length() - i);
            lastOccurrence[c - 'a'] = i;
        }

        return total;
    }
}