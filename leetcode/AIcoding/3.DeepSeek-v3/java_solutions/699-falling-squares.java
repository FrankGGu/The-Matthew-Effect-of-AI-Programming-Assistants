class Solution {
    public List<Integer> fallingSquares(int[][] positions) {
        List<Integer> res = new ArrayList<>();
        List<int[]> intervals = new ArrayList<>();
        int maxHeight = 0;

        for (int[] pos : positions) {
            int left = pos[0];
            int size = pos[1];
            int right = left + size;
            int height = size;

            for (int[] interval : intervals) {
                if (interval[1] > left && interval[0] < right) {
                    height = Math.max(height, interval[2] + size);
                }
            }

            intervals.add(new int[]{left, right, height});
            maxHeight = Math.max(maxHeight, height);
            res.add(maxHeight);
        }

        return res;
    }
}