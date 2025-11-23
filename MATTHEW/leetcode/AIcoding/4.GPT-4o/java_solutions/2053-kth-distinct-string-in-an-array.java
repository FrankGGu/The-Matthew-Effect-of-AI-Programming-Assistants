import java.util.HashMap;

public class Solution {
    public String kthDistinct(String[] arr, int k) {
        HashMap<String, Integer> countMap = new HashMap<>();

        for (String str : arr) {
            countMap.put(str, countMap.getOrDefault(str, 0) + 1);
        }

        int distinctCount = 0;
        for (String str : arr) {
            if (countMap.get(str) == 1) {
                distinctCount++;
                if (distinctCount == k) {
                    return str;
                }
            }
        }

        return "";
    }
}