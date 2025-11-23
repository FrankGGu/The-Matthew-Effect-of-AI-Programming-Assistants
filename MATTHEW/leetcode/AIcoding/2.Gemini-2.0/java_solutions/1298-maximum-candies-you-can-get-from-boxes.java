import java.util.Queue;
import java.util.LinkedList;
import java.util.List;
import java.util.ArrayList;

class Solution {
    public int maxCandies(int[] status, int[] candies, int[][] keys, int[][] containedBoxes, int[] initialBoxes) {
        int n = status.length;
        boolean[] hasBox = new boolean[n];
        boolean[] opened = new boolean[n];
        Queue<Integer> q = new LinkedList<>();
        for (int box : initialBoxes) {
            hasBox[box] = true;
            q.offer(box);
        }

        int ans = 0;
        while (!q.isEmpty()) {
            int box = q.poll();
            if (hasBox[box] && !opened[box] && (status[box] == 1 || opened[box] || hasKey(box, status, opened, keys))) {
                opened[box] = true;
                ans += candies[box];
                for (int key : keys[box]) {
                    status[key] = 1;
                    if (hasBox[key] && !opened[key]) {
                        q.offer(key);
                    }
                }
                for (int containedBox : containedBoxes[box]) {
                    hasBox[containedBox] = true;
                    q.offer(containedBox);
                }
            } else {
                boolean canOpen = false;
                for(int i = 0; i < n; i++){
                    if(hasBox[i] && !opened[i] && (status[i] == 1 || opened[i] || hasKey(i, status, opened, keys))){
                        canOpen = true;
                        break;
                    }
                }
                if(!canOpen) break;
                q.offer(box);

            }
        }
        return ans;
    }

    private boolean hasKey(int box, int[] status, boolean[] opened, int[][] keys) {
        return status[box] == 1;
    }
}