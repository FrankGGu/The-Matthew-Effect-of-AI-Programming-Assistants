class Solution {
    public char findKthCharacter(String s, int k) {
        int n = s.length();
        int len = 1;
        int total = 0;

        while (total + len < k) {
            total += len;
            len++;
        }

        int index = k - total - 1;
        return s.charAt(index % n);
    }
}