class Solution {
    public int maximizeSquareArea(int n, int m) {
        long MOD = 1_000_000_007;

        // The available horizontal fence positions are y = 0, 1, ..., n, n+1.
        // The available vertical fence positions are x = 0, 1, ..., m, m+1.

        // To form a square of side length 's', we need to choose two horizontal fences
        // at y1 and y2 such that y2 - y1 = s, and two vertical fences at x1 and x2
        // such that x2 - x1 = s.

        // Consider the horizontal fences: {0, 1, ..., n, n+1}.
        // Any integer difference 's' from 1 to (n+1) can be achieved.
        // For example, to get a difference 's', we can choose y1 = 0 and y2 = s.
        // This is valid as long as s <= n+1, because both 0 and s will be among the available horizontal fence positions.
        // So, the set of all possible horizontal side lengths is {1, 2, ..., n+1}.

        // Similarly, consider the vertical fences: {0, 1, ..., m, m+1}.
        // Any integer difference 's' from 1 to (m+1) can be achieved.
        // For example, to get a difference 's', we can choose x1 = 0 and x2 = s.
        // This is valid as long as s <= m+1, because both 0 and s will be among the available vertical fence positions.
        // So, the set of all possible vertical side lengths is {1, 2, ..., m+1}.

        // For a square of side length 's' to be formed, 's' must be achievable by both horizontal and vertical fences.
        // Therefore, 's' must be in the intersection of these two sets of possible side lengths:
        // {1, 2, ..., n+1} INTERSECT {1, 2, ..., m+1}
        // This intersection is {1, 2, ..., min(n+1, m+1)}.

        // To maximize the area of the square, we need to maximize its side length 's'.
        // The maximum possible side length 's' is min(n+1, m+1).

        long maxSide = Math.min((long)n + 1, (long)m + 1);

        // The area of the square is maxSide * maxSide.
        // The result should be returned modulo 10^9 + 7.
        long area = (maxSide * maxSide) % MOD;

        return (int) area;
    }
}