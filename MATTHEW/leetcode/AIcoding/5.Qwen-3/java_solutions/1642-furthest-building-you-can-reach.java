public class Solution {

import java.util.PriorityQueue;

public class Solution {
    public int furthestBuilding(int[] buildings, int bricks, int ladders) {
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();

        for (int i = 0; i < buildings.length - 1; i++) {
            int diff = buildings[i + 1] - buildings[i];
            if (diff > 0) {
                minHeap.add(diff);
                if (minHeap.size() > ladders) {
                    bricks -= minHeap.poll();
                }
                if (bricks < 0) {
                    return i;
                }
            }
        }

        return buildings.length - 1;
    }
}
}