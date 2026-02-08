class Solution {
    private int max = 0;

    public int maximumRequests(int n, int[][] requests) {
        int[] buildings = new int[n];
        backtrack(requests, buildings, 0, 0);
        return max;
    }

    private void backtrack(int[][] requests, int[] buildings, int index, int count) {
        if (index == requests.length) {
            for (int num : buildings) {
                if (num != 0) {
                    return;
                }
            }
            max = Math.max(max, count);
            return;
        }

        int from = requests[index][0];
        int to = requests[index][1];

        buildings[from]--;
        buildings[to]++;
        backtrack(requests, buildings, index + 1, count + 1);

        buildings[from]++;
        buildings[to]--;
        backtrack(requests, buildings, index + 1, count);
    }
}