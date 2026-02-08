import java.util.Arrays;

class Solution {
    public int earliestFullBloom(int[] plantTime, int[] growTime) {
        int n = plantTime.length;
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, (a, b) -> growTime[b] - growTime[a]);

        int currentTime = 0;
        int maxBloomTime = 0;

        for (int i = 0; i < n; i++) {
            int index = indices[i];
            currentTime += plantTime[index];
            maxBloomTime = Math.max(maxBloomTime, currentTime + growTime[index]);
        }

        return maxBloomTime;
    }
}