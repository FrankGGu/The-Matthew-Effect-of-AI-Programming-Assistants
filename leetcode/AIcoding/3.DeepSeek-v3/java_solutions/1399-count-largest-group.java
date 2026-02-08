class Solution {
    public int countLargestGroup(int n) {
        int[] count = new int[37];
        for (int i = 1; i <= n; i++) {
            int sum = 0;
            int num = i;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            count[sum]++;
        }
        int max = 0;
        int res = 0;
        for (int c : count) {
            if (c > max) {
                max = c;
                res = 1;
            } else if (c == max) {
                res++;
            }
        }
        return res;
    }
}