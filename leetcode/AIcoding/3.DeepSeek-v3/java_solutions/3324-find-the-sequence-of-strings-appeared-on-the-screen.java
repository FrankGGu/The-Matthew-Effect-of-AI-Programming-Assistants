class Solution {
    public int[] findScreen(int width, int height) {
        int gcd = gcd(width, height);
        return new int[]{width / gcd, height / gcd};
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}