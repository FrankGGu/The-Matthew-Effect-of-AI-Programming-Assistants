class Solution {
    public double soupServings(int N) {
        if (N > 5000) return 1.0;
        return helper(N, N);
    }

    private double helper(int A, int B) {
        if (A <= 0 && B <= 0) return 0.5;
        if (A <= 0) return 1.0;
        if (B <= 0) return 0.0;
        return 0.25 * (helper(A - 100, B) + helper(A - 75, B - 25) + helper(A - 50, B - 50) + helper(A - 25, B - 75));
    }
}