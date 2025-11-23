import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int numOfWays(String[] clothes) {
        Map<String, Integer> map = new HashMap<>();
        for (String cloth : clothes) {
            String[] parts = cloth.split(":");
            String type = parts[1];
            map.put(type, map.getOrDefault(type, 0) + 1);
        }
        int result = 1;
        for (int count : map.values()) {
            result *= (count + 1);
        }
        return result - 1;
    }
}