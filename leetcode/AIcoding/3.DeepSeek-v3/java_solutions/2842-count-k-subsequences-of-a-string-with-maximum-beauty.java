class Solution {
    public int countKSubsequencesWithMaxBeauty(String s, int k) {
        int MOD = 1_000_000_007;
        Map<Character, Integer> freq = new HashMap<>();
        for (char c : s.toCharArray()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }

        if (freq.size() < k) {
            return 0;
        }

        List<Integer> frequencies = new ArrayList<>(freq.values());
        frequencies.sort((a, b) -> b - a);

        long result = 1;
        int lastFreq = frequencies.get(k - 1);
        int count = 0;
        int total = 0;

        for (int f : frequencies) {
            if (f > lastFreq) {
                total++;
            } else if (f == lastFreq) {
                count++;
            }
        }

        int m = k - total;
        for (int i = 0; i < total; i++) {
            result = (result * frequencies.get(i)) % MOD;
        }

        long comb = 1;
        for (int i = 1; i <= m; i++) {
            comb = comb * (count - i + 1) / i;
        }

        result = (result * comb) % MOD;
        for (int i = 0; i < m; i++) {
            result = (result * lastFreq) % MOD;
        }

        return (int) result;
    }
}