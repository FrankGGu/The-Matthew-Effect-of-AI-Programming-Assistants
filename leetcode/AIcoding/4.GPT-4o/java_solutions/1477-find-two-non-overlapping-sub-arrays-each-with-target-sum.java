import java.util.HashMap;

public class Solution {
    public int minSumOfLengths(int[] arr, int target) {
        HashMap<Integer, Integer> map = new HashMap<>();
        int n = arr.length;
        int minLength = Integer.MAX_VALUE;
        int[] prefixSum = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + arr[i];
        }

        for (int i = 0; i <= n; i++) {
            int needed = prefixSum[i] - target;
            if (map.containsKey(needed)) {
                minLength = Math.min(minLength, i - map.get(needed));
            }
            map.put(prefixSum[i], i);
        }

        int answer = Integer.MAX_VALUE;
        map.clear();

        for (int i = 0; i <= n; i++) {
            int needed = prefixSum[i] - target;
            if (map.containsKey(needed)) {
                answer = Math.min(answer, i - map.get(needed) + (minLength == Integer.MAX_VALUE ? 0 : minLength));
            }
            if (i > 0) {
                map.put(prefixSum[i - 1], i - 1);
            }
        }

        return answer == Integer.MAX_VALUE ? -1 : answer;
    }
}