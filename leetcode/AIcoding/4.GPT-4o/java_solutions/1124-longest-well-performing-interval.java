import java.util.HashMap;

public class Solution {
    public int longestWPI(int[] hours) {
        HashMap<Integer, Integer> map = new HashMap<>();
        int maxLength = 0, sum = 0;

        for (int i = 0; i < hours.length; i++) {
            sum += hours[i] > 8 ? 1 : -1;
            if (sum > 0) {
                maxLength = i + 1;
            } else {
                if (map.containsKey(sum - 1)) {
                    maxLength = Math.max(maxLength, i - map.get(sum - 1));
                }
                map.putIfAbsent(sum, i);
            }
        }
        return maxLength;
    }
}