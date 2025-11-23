import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public String[] sortPeople(String[] names, int[] heights) {
        Map<Integer, String> map = new HashMap<>();
        for (int i = 0; i < names.length; i++) {
            map.put(heights[i], names[i]);
        }
        Arrays.sort(heights);
        String[] result = new String[names.length];
        for (int i = 0; i < names.length; i++) {
            result[i] = map.get(heights[names.length - 1 - i]);
        }
        return result;
    }
}