class Solution {
    public int minCharacters(String a, String b) {
        int m = a.length(), n = b.length();
        int[] countA = new int[26];
        int[] countB = new int[26];

        for (char c : a.toCharArray()) {
            countA[c - 'a']++;
        }
        for (char c : b.toCharArray()) {
            countB[c - 'a']++;
        }

        int res = Integer.MAX_VALUE;

        for (int i = 0; i < 26; i++) {
            res = Math.min(res, m + n - countA[i] - countB[i]);
        }

        int case1 = 0, case2 = 0;
        for (int i = 1; i < 26; i++) {
            case1 += countA[i - 1];
            case2 += countB[i - 1];
            res = Math.min(res, Math.min(case1 + n - case2, case2 + m - case1));
        }

        return res;
    }
}