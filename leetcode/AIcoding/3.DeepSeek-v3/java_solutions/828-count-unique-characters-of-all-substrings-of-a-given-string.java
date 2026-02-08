class Solution {
    public int uniqueLetterString(String s) {
        int n = s.length();
        int[] lastPos = new int[26];
        int[] contribution = new int[26];
        Arrays.fill(lastPos, -1);
        int res = 0;
        int total = 0;

        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            int idx = c - 'A';
            total -= contribution[idx];
            contribution[idx] = i - lastPos[idx];
            total += contribution[idx];
            lastPos[idx] = i;
            res += total;
        }

        return res;
    }
}