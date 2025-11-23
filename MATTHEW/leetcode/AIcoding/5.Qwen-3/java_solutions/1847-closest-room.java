public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> closestRoom(int[][] reviews, int[] queries) {
        int n = reviews.length;
        int m = queries.length;
        List<Integer> result = new ArrayList<>();

        List<int[]> reviewList = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            reviewList.add(new int[]{reviews[i][0], reviews[i][1]});
        }

        Collections.sort(reviewList, (a, b) -> a[0] - b[0]);

        List<int[]> queryList = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            queryList.add(new int[]{queries[i], i});
        }

        Collections.sort(queryList, (a, b) -> a[0] - b[0]);

        TreeSet<Integer> availableRooms = new TreeSet<>();
        int ptr = 0;

        for (int[] q : queryList) {
            int target = q[0];
            int index = q[1];

            while (ptr < n && reviewList.get(ptr)[0] <= target) {
                availableRooms.add(reviewList.get(ptr)[1]);
                ptr++;
            }

            if (availableRooms.isEmpty()) {
                result.add(-1);
            } else {
                Integer closest = null;
                int minDiff = Integer.MAX_VALUE;

                for (int room : availableRooms) {
                    int diff = Math.abs(room - target);
                    if (diff < minDiff) {
                        minDiff = diff;
                        closest = room;
                    } else if (diff == minDiff && room < closest) {
                        closest = room;
                    }
                }

                result.add(closest);
            }
        }

        List<Integer> finalResult = new ArrayList<>(m);
        for (int i = 0; i < m; i++) {
            finalResult.add(-1);
        }

        for (int i = 0; i < m; i++) {
            finalResult.set(queryList.get(i)[1], result.get(i));
        }

        return finalResult;
    }
}
}