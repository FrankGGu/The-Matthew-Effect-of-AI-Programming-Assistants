import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int earliestFullBloom(int[] plantTime, int[] growTime) {
        int n = plantTime.length;

        List<int[]> flowers = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            flowers.add(new int[]{plantTime[i], growTime[i]});
        }

        Collections.sort(flowers, (a, b) -> b[1] - a[1]);

        int currentTime = 0;
        int maxBloomTime = 0;

        for (int[] flower : flowers) {
            int p = flower[0];
            int g = flower[1];

            currentTime += p;
            maxBloomTime = Math.max(maxBloomTime, currentTime + g);
        }

        return maxBloomTime;
    }
}