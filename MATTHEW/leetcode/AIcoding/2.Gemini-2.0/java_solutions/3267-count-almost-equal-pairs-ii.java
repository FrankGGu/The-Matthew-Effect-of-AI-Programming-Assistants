import java.util.TreeMap;

class Solution {
    public long countAlmostEqualPairs(int[] nums, int diff) {
        long count = 0;
        TreeMap<Integer, Integer> map = new TreeMap<>();
        for (int num : nums) {
            Integer lower = map.floorKey(num + diff);
            while (lower != null && lower >= num - diff) {
                count += map.get(lower);
                lower = map.floorKey(lower - 1);
            }
            map.put(num, map.getOrDefault(num, 0) + 1);
        }
        return count;
    }
}