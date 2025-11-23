class Solution {
    public int[] closestDivisors(int num) {
        int[] res1 = findDivisors(num + 1);
        int[] res2 = findDivisors(num + 2);
        if (Math.abs(res1[0] - res1[1]) < Math.abs(res2[0] - res2[1])) {
            return res1;
        } else {
            return res2;
        }
    }

    private int[] findDivisors(int n) {
        int[] res = new int[]{1, n};
        for (int i = (int) Math.sqrt(n); i >= 1; i--) {
            if (n % i == 0) {
                res[0] = i;
                res[1] = n / i;
                break;
            }
        }
        return res;
    }
}