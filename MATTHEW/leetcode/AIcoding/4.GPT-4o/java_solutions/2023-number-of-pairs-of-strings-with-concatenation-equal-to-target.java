import java.util.HashMap;

public class Solution {
    public int countPairs(String[] strings, String target) {
        HashMap<String, Integer> map = new HashMap<>();
        int count = 0;

        for (String str : strings) {
            String complement = target.substring(0, target.length() - str.length());
            count += map.getOrDefault(complement, 0);
            map.put(str, map.getOrDefault(str, 0) + 1);
        }

        return count;
    }
}