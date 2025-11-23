import java.util.*;

public class Solution {
    public List<String> rearrangeFruits(List<String> fruits) {
        Map<String, Integer> countMap = new HashMap<>();
        for (String fruit : fruits) {
            countMap.put(fruit, countMap.getOrDefault(fruit, 0) + 1);
        }
        List<Map.Entry<String, Integer>> entryList = new ArrayList<>(countMap.entrySet());
        entryList.sort((a, b) -> b.getValue().compareTo(a.getValue()));

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : entryList) {
            int count = entry.getValue();
            for (int i = 0; i < count; i++) {
                result.add(entry.getKey());
            }
        }
        return result;
    }
}