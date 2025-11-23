class Solution {
    public int[] closestDivisors(int n) {
        int[] result = new int[2];
        int closestDifference = Integer.MAX_VALUE;

        for (int i = (int) Math.sqrt(n + 1); i >= 1; i--) {
            if ((n + 1) % i == 0) {
                int a = i;
                int b = (n + 1) / i;
                if (Math.abs(a - b) < closestDifference) {
                    closestDifference = Math.abs(a - b);
                    result[0] = a;
                    result[1] = b;
                }
            }
        }

        for (int i = (int) Math.sqrt(n + 2); i >= 1; i--) {
            if ((n + 2) % i == 0) {
                int a = i;
                int b = (n + 2) / i;
                if (Math.abs(a - b) < closestDifference) {
                    closestDifference = Math.abs(a - b);
                    result[0] = a;
                    result[1] = b;
                }
            }
        }

        return result;
    }
}