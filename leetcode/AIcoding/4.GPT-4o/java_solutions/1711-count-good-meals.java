import java.util.HashMap;

public class Solution {
    public int countGoodMeals(int[] deliciousness) {
        HashMap<Integer, Integer> map = new HashMap<>();
        int mod = 1000000007;
        long count = 0;

        for (int num : deliciousness) {
            for (int i = 0; i <= 21; i++) {
                int target = (1 << i) - num;
                if (map.containsKey(target)) {
                    count = (count + map.get(target)) % mod;
                }
            }
            map.put(num, map.getOrDefault(num, 0) + 1);
        }

        return (int) count;
    }
}