class Solution {
    public int[] circularGameLosers(int n, int k) {
        boolean[] visited = new boolean[n];
        int current = 0;
        int step = 1;
        while (!visited[current]) {
            visited[current] = true;
            current = (current + step * k) % n;
            step++;
        }
        List<Integer> losers = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                losers.add(i + 1);
            }
        }
        int[] result = new int[losers.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = losers.get(i);
        }
        return result;
    }
}