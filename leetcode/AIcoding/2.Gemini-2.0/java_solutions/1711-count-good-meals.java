import java.util.HashMap;

class Solution {
    public int countGoodMeals(int[] deliciousness) {
        HashMap<Integer, Integer> count = new HashMap<>();
        int MOD = 1000000007;
        long ans = 0;

        for (int d : deliciousness) {
            for (int i = 0; i < 22; i++) {
                int powerOfTwo = 1 << i;
                if (count.containsKey(powerOfTwo - d)) {
                    ans = (ans + count.get(powerOfTwo - d)) % MOD;
                }
            }
            count.put(d, count.getOrDefault(d, 0) + 1);
        }

        return (int) ans;
    }
}