class Solution {
    public int maxCandies(int[] status, int[] candies, int[][] keys, int[][] containedBoxes, int[] initialBoxes) {
        int n = status.length;
        boolean[] hasBox = new boolean[n];
        boolean[] hasKey = new boolean[n];
        boolean[] opened = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();

        for (int box : initialBoxes) {
            hasBox[box] = true;
            if (status[box] == 1) {
                opened[box] = true;
                queue.offer(box);
            }
        }

        int total = 0;
        while (!queue.isEmpty()) {
            int curr = queue.poll();
            total += candies[curr];

            for (int key : keys[curr]) {
                hasKey[key] = true;
                if (hasBox[key] && !opened[key]) {
                    opened[key] = true;
                    queue.offer(key);
                }
            }

            for (int box : containedBoxes[curr]) {
                hasBox[box] = true;
                if ((status[box] == 1 || hasKey[box]) && !opened[box]) {
                    opened[box] = true;
                    queue.offer(box);
                }
            }
        }

        return total;
    }
}