import java.util.HashMap;

public class Solution {
    public boolean canCross(int[] stones) {
        HashMap<Integer, HashMap<Integer, Boolean>> map = new HashMap<>();
        for (int stone : stones) {
            map.put(stone, new HashMap<>());
        }
        return canCross(stones, 0, 0, map);
    }

    private boolean canCross(int[] stones, int position, int jump, HashMap<Integer, HashMap<Integer, Boolean>> map) {
        if (position == stones[stones.length - 1]) {
            return true;
        }
        if (map.get(position).containsKey(jump)) {
            return map.get(position).get(jump);
        }
        for (int i = -1; i <= 1; i++) {
            int nextJump = jump + i;
            if (nextJump > 0) {
                int nextPosition = position + nextJump;
                if (binarySearch(stones, nextPosition)) {
                    if (canCross(stones, nextPosition, nextJump, map)) {
                        map.get(position).put(jump, true);
                        return true;
                    }
                }
            }
        }
        map.get(position).put(jump, false);
        return false;
    }

    private boolean binarySearch(int[] stones, int target) {
        int left = 0, right = stones.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (stones[mid] == target) {
                return true;
            } else if (stones[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return false;
    }
}