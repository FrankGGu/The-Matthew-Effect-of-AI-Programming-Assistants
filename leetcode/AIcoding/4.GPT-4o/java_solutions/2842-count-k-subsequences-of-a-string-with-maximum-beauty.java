import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int countKSubsequencesWithMaxBeauty(String s, int k) {
        Map<Character, Integer> countMap = new HashMap<>();
        for (char c : s.toCharArray()) {
            countMap.put(c, countMap.getOrDefault(c, 0) + 1);
        }

        int[] freq = countMap.values().stream().mapToInt(i -> i).toArray();
        int n = freq.length;
        if (n < k) return 0;

        Arrays.sort(freq);
        long result = 1;
        for (int i = n - k; i < n; i++) {
            result = (result * freq[i]) % 1000000007;
        }

        return (int) result;
    }
}