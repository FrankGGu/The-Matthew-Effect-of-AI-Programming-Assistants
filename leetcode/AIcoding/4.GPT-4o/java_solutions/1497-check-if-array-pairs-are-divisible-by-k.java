import java.util.HashMap;

class Solution {
    public boolean canArrange(int[] arr, int k) {
        HashMap<Integer, Integer> countMap = new HashMap<>();
        for (int num : arr) {
            int mod = ((num % k) + k) % k;
            countMap.put(mod, countMap.getOrDefault(mod, 0) + 1);
        }
        for (int i = 1; i < k; i++) {
            if (countMap.getOrDefault(i, 0) != countMap.getOrDefault(k - i, 0)) {
                return false;
            }
        }
        return countMap.getOrDefault(0, 0) % 2 == 0;
    }
}