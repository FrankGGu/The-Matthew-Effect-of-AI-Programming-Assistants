import java.util.Arrays;

class Solution {

    public double findMinimumLogTransportationCost(int[] x, int[] w) {
        int n = x.length;

        // P[k] = sum of weights w_0 to w_{k-1}
        // Q[k] = sum of weighted positions (w_0*x_0 + ... + w_{k-1}*x_{k-1})
        // R[k] = sum of weighted squared positions (w_0*x_0^2 + ... + w_{k-1}*x_{k-1}^2)
        // All prefix sums use long to prevent overflow for intermediate products,
        // assuming x_i and w_i are within reasonable bounds (e.g., up to 1000)
        // that allow (w_i * x_i^2) to fit in long, and total sums to fit in long.
        // If x_i or w_i are very large (e.g., 10^9), then R and Q might need to be double.
        // For typical competitive programming constraints, long is sufficient.
        long[] P = new long[n + 1]; 
        long[] Q = new long[n + 1]; 
        long[] R = new long[n + 1]; 

        for (int i = 0; i < n; i++) {
            P[i + 1] = P[i] + w[i];
            Q[i + 1] = Q[i] + (long) w[i] * x[i];
            R[i + 1] = R[i] + (long) w[i] * x[i] * x[i];
        }

        // dp[i] stores the minimum cost to transport logs from index 0 to i-1.
        // dp[0] = 0 (cost for no logs)
        double[] dp = new double[n + 1];
        Arrays.fill(dp, Double.POSITIVE_INFINITY);
        dp[0] = 0;

        // Solve the DP using Divide and Conquer Optimization (Knuth's Optimization variant)
        // This optimization applies because the cost function satisfies the quadrangle inequality,
        // implying that the optimal split point for dp[i] is non-decreasing with i.
        // We compute dp[i] for i from 1 to n.
        solve(1, n, 0, n - 1, dp, P, Q, R);

        return dp[n];
    }

    private double calculateCost(int j, int i, long[] P, long[] Q, long[] R) {
        // P[i] - P[j] is the sum of weights for logs from index j to i-1.
        // This value should be positive since i > j and w_k > 0.
        long P_segment = P[i] - P[j];
        if (P_segment == 0) {
            // This case should ideally not be reached if w_k > 0 and i > j.
            // If it can be reached (e.g., w_k=0 allowed), return 0 cost for empty segment.
            return 0; 
        }

        long Q_segment = Q[i] - Q[j]; // Sum of weighted positions for the segment
        long R_segment = R[i] - R[j]; // Sum of weighted squared positions for the segment

        // Cost = (sum w_k x_k^2) - (sum w_k x_k)^2 / (sum w_k)
        // Use double for division to maintain precision.
        return (double)R_segment - (double)Q_segment * Q_segment / P_segment;
    }

    private void solve(int L, int R, int optL, int optR, double[] dp, long[] P, long[] Q, long[] R) {
        if (L > R) {
            return;
        }

        int mid = L + (R - L) / 2;
        int bestJ = -1;
        double minCost = Double.POSITIVE_INFINITY;

        // Iterate through possible split points `j` for `dp[mid]`.
        // `j` represents the end of the previous segment (0-indexed).
        // The current segment is from `j` to `mid-1`.
        // `j` can range from `optL` to `min(mid - 1, optR)`.
        // `mid - 1` ensures `j` is strictly less than `mid`.
        for (int j = optL; j <= Math.min(mid - 1, optR); j++) {
            double currentCost = dp[j] + calculateCost(j, mid, P, Q, R);
            if (currentCost < minCost) {
                minCost = currentCost;
                bestJ = j;
            }
        }

        dp[mid] = minCost;

        // Recursively solve for the left and right halves.
        // For the left half `[L, mid-1]`, the optimal split point `j` is in `[optL, bestJ]`.
        solve(L, mid - 1, optL, bestJ, dp, P, Q, R);
        // For the right half `[mid+1, R]`, the optimal split point `j` is in `[bestJ, optR]`.
        solve(mid + 1, R, bestJ, optR, dp, P, Q, R);
    }
}