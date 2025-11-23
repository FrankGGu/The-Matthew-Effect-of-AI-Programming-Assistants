class Solution {
    public int countDays(int days, int[][] meetings) {
        Arrays.sort(meetings, (a, b) -> a[0] - b[0]);
        int res = 0;
        int last = 0;
        for (int[] meeting : meetings) {
            int start = meeting[0];
            int end = meeting[1];
            if (start > last + 1) {
                res += start - last - 1;
            }
            last = Math.max(last, end);
        }
        if (last < days) {
            res += days - last;
        }
        return res;
    }
}