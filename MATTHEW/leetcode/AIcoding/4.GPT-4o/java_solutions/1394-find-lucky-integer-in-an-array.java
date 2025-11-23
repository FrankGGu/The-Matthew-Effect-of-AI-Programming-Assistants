import java.util.HashMap;

class Solution {
    public int findLucky(int[] arr) {
        HashMap<Integer, Integer> countMap = new HashMap<>();
        for (int num : arr) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
        int lucky = -1;
        for (int num : countMap.keySet()) {
            if (num == countMap.get(num)) {
                lucky = Math.max(lucky, num);
            }
        }
        return lucky;
    }
}