class Solution {
    public int distinctNumbersInIntervals(int[][] intervals) {
        Set<Integer> distinctNumbers = new HashSet<>();
        for (int[] interval : intervals) {
            for (int num = interval[0]; num <= interval[1]; num++) {
                distinctNumbers.add(num);
            }
        }
        return distinctNumbers.size();
    }
}