import java.util.*;

class Solution {
    public int closestRoom(int[][] rooms, int k) {
        int n = rooms.length;
        Arrays.sort(rooms, (a, b) -> b[1] - a[1]);

        TreeSet<Integer> sizes = new TreeSet<>();
        int maxSize = 0;
        int count = 0;

        for (int i = 0; i < n; i++) {
            if ((i > 0 && rooms[i][1] < rooms[i - 1][1]) || i == n - 1) {
                while (count < k && maxSize < sizes.size()) {
                    Integer size = sizes.pollLast();
                    if (size != null) {
                        count++;
                        maxSize = Math.max(maxSize, size);
                    }
                }
            }
            sizes.add(rooms[i][1]);
        }

        return maxSize;
    }
}