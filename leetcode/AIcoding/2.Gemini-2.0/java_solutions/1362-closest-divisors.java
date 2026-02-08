class Solution {
    public int[] closestDivisors(int num) {
        int a = num + 1;
        int b = num + 2;
        int[] resA = findClosestDivisors(a);
        int[] resB = findClosestDivisors(b);

        if (Math.abs(resA[0] - resA[1]) <= Math.abs(resB[0] - resB[1])) {
            return resA;
        } else {
            return resB;
        }
    }

    private int[] findClosestDivisors(int num) {
        int a = 1;
        int b = num;
        for (int i = (int) Math.sqrt(num); i >= 1; i--) {
            if (num % i == 0) {
                a = i;
                b = num / i;
                break;
            }
        }
        return new int[]{a, b};
    }
}