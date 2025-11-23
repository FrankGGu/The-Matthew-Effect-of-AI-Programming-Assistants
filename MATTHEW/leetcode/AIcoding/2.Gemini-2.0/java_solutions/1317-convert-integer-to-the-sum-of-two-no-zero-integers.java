class Solution {
    public int[] getNoZeroIntegers(int n) {
        int a = 1;
        while (hasZero(a) || hasZero(n - a)) {
            a++;
        }
        return new int[]{a, n - a};
    }

    private boolean hasZero(int n) {
        String s = String.valueOf(n);
        return s.contains("0");
    }
}