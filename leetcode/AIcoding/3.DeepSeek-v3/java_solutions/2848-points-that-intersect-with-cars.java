class Solution {
    public int numberOfPoints(List<List<Integer>> nums) {
        boolean[] covered = new boolean[101];
        for (List<Integer> interval : nums) {
            int start = interval.get(0);
            int end = interval.get(1);
            for (int i = start; i <= end; i++) {
                covered[i] = true;
            }
        }
        int count = 0;
        for (boolean b : covered) {
            if (b) {
                count++;
            }
        }
        return count;
    }
}