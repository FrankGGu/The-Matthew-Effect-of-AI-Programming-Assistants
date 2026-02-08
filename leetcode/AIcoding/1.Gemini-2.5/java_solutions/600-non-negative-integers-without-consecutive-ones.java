class Solution {
    public int findIntegers(int n) {
        int[] fib = new int[31];
        fib[0] = 1;
        fib[1] = 2;
        for (int i = 2; i < 31; i++) {
            fib[i] = fib[i - 1] + fib[i - 2];
        }

        int count = 0;
        boolean prevOne = false;
        boolean broken = false;

        for (int i = 30; i >= 0; i--) {
            if (((n >> i) & 1) == 1) {
                count += fib[i];

                if (prevOne) {
                    broken = true;
                    break;
                }
                prevOne = true;
            } else {
                prevOne = false;
            }
        }

        if (!broken) {
            count++;
        }

        return count;
    }
}