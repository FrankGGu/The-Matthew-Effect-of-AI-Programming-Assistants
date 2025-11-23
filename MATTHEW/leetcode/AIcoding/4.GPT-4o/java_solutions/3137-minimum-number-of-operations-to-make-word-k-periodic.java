class Solution {
    public int minOperations(String s, int k) {
        int n = s.length();
        int[] count = new int[26];
        int ans = Integer.MAX_VALUE;

        for (int i = 0; i < k; i++) {
            Arrays.fill(count, 0);
            for (int j = i; j < n; j += k) {
                count[s.charAt(j) - 'a']++;
            }

            int maxCount = 0;
            for (int c : count) {
                maxCount = Math.max(maxCount, c);
            }
            ans = Math.min(ans, (n / k) - maxCount + (n % k > i ? 1 : 0));
        }

        return ans;
    }
}