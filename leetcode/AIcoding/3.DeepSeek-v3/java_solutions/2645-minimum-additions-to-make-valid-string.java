class Solution {
    public int addMinimum(String word) {
        int res = 0;
        int n = word.length();
        int i = 0;
        while (i < n) {
            if (i + 2 < n && word.charAt(i) == 'a' && word.charAt(i + 1) == 'b' && word.charAt(i + 2) == 'c') {
                i += 3;
            } else if (i + 1 < n && word.charAt(i) == 'a' && word.charAt(i + 1) == 'b') {
                res += 1;
                i += 2;
            } else if (i + 1 < n && word.charAt(i) == 'a' && word.charAt(i + 1) == 'c') {
                res += 1;
                i += 2;
            } else if (i + 1 < n && word.charAt(i) == 'b' && word.charAt(i + 1) == 'c') {
                res += 1;
                i += 2;
            } else if (word.charAt(i) == 'a') {
                res += 2;
                i += 1;
            } else if (word.charAt(i) == 'b') {
                res += 2;
                i += 1;
            } else if (word.charAt(i) == 'c') {
                res += 2;
                i += 1;
            }
        }
        return res;
    }
}