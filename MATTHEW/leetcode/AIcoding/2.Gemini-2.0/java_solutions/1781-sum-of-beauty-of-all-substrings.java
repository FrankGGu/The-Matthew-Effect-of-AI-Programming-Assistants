class Solution {
    public int beautySum(String s) {
        int n = s.length();
        int ans = 0;
        for (int i = 0; i < n; i++) {
            int[] count = new int[26];
            for (int j = i; j < n; j++) {
                count[s.charAt(j) - 'a']++;
                int max = 0;
                int min = Integer.MAX_VALUE;
                for (int k = 0; k < 26; k++) {
                    if (count[k] > 0) {
                        max = Math.max(max, count[k]);
                        min = Math.min(min, count[k]);
                    }
                }
                ans += max - min;
            }
        }
        return ans;
    }
}