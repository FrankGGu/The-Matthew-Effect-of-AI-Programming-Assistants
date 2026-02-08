class Solution {
    public char findKthCharacter(String s, int k) {
        int n = s.length();
        int size = 1, length = 0;

        while (length + size < k) {
            length += size;
            size *= 2;
        }

        k -= length;
        return getKthCharacter(s, k - 1, size / 2);
    }

    private char getKthCharacter(String s, int k, int size) {
        if (size == 1) return s.charAt(k);
        if (k < size / 2) {
            return getKthCharacter(s, k, size / 2);
        } else {
            return getKthCharacter(s, k - size / 2, size / 2);
        }
    }
}