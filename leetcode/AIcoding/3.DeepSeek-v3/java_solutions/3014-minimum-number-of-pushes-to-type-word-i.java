class Solution {
    public int minimumPushes(String word) {
        int[] freq = new int[26];
        for (char c : word.toCharArray()) {
            freq[c - 'a']++;
        }
        Arrays.sort(freq);
        int res = 0;
        for (int i = 25; i >= 0; i--) {
            if (freq[i] == 0) break;
            int pos = 25 - i;
            int cost = (pos / 8) + 1;
            res += cost * freq[i];
        }
        return res;
    }
}