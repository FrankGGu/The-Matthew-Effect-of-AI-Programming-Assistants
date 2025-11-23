class Solution {
    public int[] circularGameLosers(int n, int k) {
        boolean[] visited = new boolean[n];
        int current = 0;
        int step = k;
        visited[current] = true;

        while (true) {
            current = (current + step) % n;
            if (visited[current]) {
                break;
            }
            visited[current] = true;
            step += k;
        }

        int count = 0;
        for (boolean b : visited) {
            if (!b) {
                count++;
            }
        }

        int[] losers = new int[count];
        int index = 0;
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                losers[index++] = i + 1;
            }
        }

        return losers;
    }
}