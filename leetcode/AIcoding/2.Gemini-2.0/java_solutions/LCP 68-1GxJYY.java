class Solution {
    public int beautifulBouquet(int[] flowers, int cnt) {
        int MOD = 1000000007;
        int n = flowers.length;
        long ans = 0;
        int left = 0;
        int[] freq = new int[100001];
        int distinct = 0;

        for (int right = 0; right < n; right++) {
            if (freq[flowers[right]] == 0) {
                distinct++;
            }
            freq[flowers[right]]++;

            while (distinct > cnt) {
                freq[flowers[left]]--;
                if (freq[flowers[left]] == 0) {
                    distinct--;
                }
                left++;
            }

            ans = (ans + (right - left + 1)) % MOD;
        }

        return (int) ans;
    }
}