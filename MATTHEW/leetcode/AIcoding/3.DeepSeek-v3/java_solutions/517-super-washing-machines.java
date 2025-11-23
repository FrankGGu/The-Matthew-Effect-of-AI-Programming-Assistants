class Solution {
    public int findMinMoves(int[] machines) {
        int total = 0;
        for (int num : machines) {
            total += num;
        }
        int n = machines.length;
        if (total % n != 0) {
            return -1;
        }
        int avg = total / n;
        int res = 0;
        int balance = 0;
        for (int num : machines) {
            balance += num - avg;
            res = Math.max(res, Math.max(Math.abs(balance), num - avg));
        }
        return res;
    }
}