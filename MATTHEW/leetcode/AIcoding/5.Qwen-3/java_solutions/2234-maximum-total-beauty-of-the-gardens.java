public class Solution {

import java.util.*;

public class Solution {
    public int maximumTotalBeauty(int[] flowers, int[] newFlowers, int[] target, int start, int end) {
        int n = flowers.length;
        int m = newFlowers.length;

        List<int[]> events = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            events.add(new int[]{start + i, newFlowers[i], 1});
            events.add(new int[]{end + i + 1, newFlowers[i], -1});
        }

        Arrays.sort(events, (a, b) -> a[0] - b[0]);

        int[] flowerCounts = new int[n];
        for (int i = 0; i < n; i++) {
            flowerCounts[i] = flowers[i];
        }

        int total = 0;
        int ptr = 0;
        int currentFlower = 0;

        for (int i = 0; i < n; i++) {
            while (ptr < events.size() && events.get(ptr)[0] <= i) {
                currentFlower += events.get(ptr)[2] * events.get(ptr)[1];
                ptr++;
            }
            if (flowerCounts[i] < target[i]) {
                int needed = Math.min(target[i] - flowerCounts[i], currentFlower);
                total += needed;
                flowerCounts[i] += needed;
                currentFlower -= needed;
            }
        }

        return total;
    }
}
}