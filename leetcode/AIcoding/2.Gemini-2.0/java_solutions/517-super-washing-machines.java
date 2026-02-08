class Solution {
    public int findMinMoves(int[] machines) {
        int total = 0;
        for (int m : machines) {
            total += m;
        }
        int n = machines.length;
        if (total % n != 0) {
            return -1;
        }
        int avg = total / n;
        int sum = 0;
        int res = 0;
        for (int m : machines) {
            int need = m - avg;
            sum += need;
            res = Math.max(res, Math.max(Math.abs(sum), need));
        }
        return res;
    }
}