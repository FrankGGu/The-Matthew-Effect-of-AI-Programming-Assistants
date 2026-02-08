class Solution {
    public int beautifulBouquet(int[] flowers, int cnt) {
        int MOD = 1000000007;
        int n = flowers.length;
        int left = 0;
        int res = 0;
        Map<Integer, Integer> freq = new HashMap<>();

        for (int right = 0; right < n; right++) {
            int flower = flowers[right];
            freq.put(flower, freq.getOrDefault(flower, 0) + 1);

            while (freq.get(flower) > cnt) {
                int leftFlower = flowers[left];
                freq.put(leftFlower, freq.get(leftFlower) - 1);
                if (freq.get(leftFlower) == 0) {
                    freq.remove(leftFlower);
                }
                left++;
            }

            res = (res + right - left + 1) % MOD;
        }

        return res;
    }
}