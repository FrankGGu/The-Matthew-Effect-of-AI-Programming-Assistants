class Solution {
    public int[] closestDivisors(int num) {
        int[] result = new int[2];
        int minDiff = Integer.MAX_VALUE;

        int target1 = num + 1;
        int sqrt1 = (int) Math.sqrt(target1);
        for (int i = sqrt1; i >= 1; i--) {
            if (target1 % i == 0) {
                int j = target1 / i;
                int currentDiff = Math.abs(i - j);
                if (currentDiff < minDiff) {
                    minDiff = currentDiff;
                    result[0] = i;
                    result[1] = j;
                }
                break;
            }
        }

        int target2 = num + 2;
        int sqrt2 = (int) Math.sqrt(target2);
        for (int i = sqrt2; i >= 1; i--) {
            if (target2 % i == 0) {
                int j = target2 / i;
                int currentDiff = Math.abs(i - j);
                if (currentDiff < minDiff) {
                    minDiff = currentDiff;
                    result[0] = i;
                    result[1] = j;
                }
                break;
            }
        }

        return result;
    }
}