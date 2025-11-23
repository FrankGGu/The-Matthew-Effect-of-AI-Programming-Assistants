import java.util.HashMap;
import java.util.Map;

class Solution {
    public String kthDistinct(String[] arr, int k) {
        Map<String, Integer> freqMap = new HashMap<>();

        for (String s : arr) {
            freqMap.put(s, freqMap.getOrDefault(s, 0) + 1);
        }

        for (String s : arr) {
            if (freqMap.get(s) == 1) {
                k--;
                if (k == 0) {
                    return s;
                }
            }
        }

        return "";
    }
}