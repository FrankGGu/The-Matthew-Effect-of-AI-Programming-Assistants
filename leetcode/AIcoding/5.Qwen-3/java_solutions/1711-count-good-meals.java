public class Solution {

import java.util.*;

public class Solution {
    public int countGoodMeals(int[] arr) {
        Map<Integer, Integer> map = new HashMap<>();
        int mod = 1000000007;
        int result = 0;

        for (int num : arr) {
            for (int i = 0; i <= 20; i++) {
                int target = (1 << i) - num;
                result = (result + map.getOrDefault(target, 0)) % mod;
            }
            map.put(num, map.getOrDefault(num, 0) + 1);
        }

        return result;
    }
}
}