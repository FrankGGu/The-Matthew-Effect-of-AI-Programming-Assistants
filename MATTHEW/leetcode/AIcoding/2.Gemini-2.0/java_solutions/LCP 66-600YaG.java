class Solution {
    public int minStands(String S) {
        int[] count = new int[26];
        for (char c : S.toCharArray()) {
            count[c - 'a']++;
        }
        int res = 0;
        for (int i = 0; i < 26; i++) {
            res = Math.max(res, count[i]);
        }
        return res;
    }
}