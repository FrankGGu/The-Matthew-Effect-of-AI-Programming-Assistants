class Solution {
    public int minimumDeletions(String s, int k) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }
        Arrays.sort(freq);
        int res = Integer.MAX_VALUE;
        for (int i = 0; i < 26; i++) {
            if (freq[i] == 0) continue;
            int temp = 0;
            int minVal = freq[i];
            int maxVal = minVal + k;
            for (int j = 0; j < 26; j++) {
                if (freq[j] < minVal) {
                    temp += freq[j];
                } else if (freq[j] > maxVal) {
                    temp += freq[j] - maxVal;
                }
            }
            res = Math.min(res, temp);
        }
        return res;
    }
}