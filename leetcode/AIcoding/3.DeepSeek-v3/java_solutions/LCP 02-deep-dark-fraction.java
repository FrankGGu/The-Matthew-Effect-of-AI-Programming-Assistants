class Solution {
    public int[] fraction(int[] cont) {
        int n = cont.length;
        int numerator = cont[n - 1];
        int denominator = 1;

        for (int i = n - 2; i >= 0; i--) {
            int temp = numerator;
            numerator = denominator + cont[i] * numerator;
            denominator = temp;
        }

        return new int[]{numerator, denominator};
    }
}