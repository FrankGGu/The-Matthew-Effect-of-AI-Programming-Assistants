import java.util.Arrays;
import java.util.Collections;

class Solution {
    int minUnfairness;
    int[] cookies;
    int k;

    public int distributeCookies(int[] cookies, int k) {
        this.cookies = cookies;
        this.k = k;
        this.minUnfairness = Integer.MAX_VALUE;

        // Sort cookies in descending order for potential pruning benefits
        Arrays.sort(this.cookies);
        for (int i = 0; i < this.cookies.length / 2; i++) {
            int temp = this.cookies[i];
            this.cookies[i] = this.cookies[this.cookies.length - 1 - i];
            this.cookies[this.cookies.length - 1 - i] = temp;
        }

        int[] childrenBags = new int[k]; // Stores total cookies for each child
        backtrack(0, childrenBags);
        return minUnfairness;
    }

    private void backtrack(int cookieIndex, int[] childrenBags) {
        // Pruning: if current max unfairness is already >= minUnfairness, stop this path
        // This check is based on the cookies distributed so far, before distributing cookies[cookieIndex].
        int currentMax = 0;
        for (int i = 0; i < k; i++) {
            currentMax = Math.max(currentMax, childrenBags[i]);
        }
        if (currentMax >= minUnfairness) {
            return;
        }

        // Base case: all cookies distributed
        if (cookieIndex == cookies.length) {
            minUnfairness = Math.min(minUnfairness, currentMax);
            return;
        }

        // Recursive step: try to give current cookie to each child
        for (int i = 0; i < k; i++) {
            childrenBags[i] += cookies[cookieIndex];
            backtrack(cookieIndex + 1, childrenBags);
            childrenBags[i] -= cookies[cookieIndex]; // Backtrack

            // Optimization: If this child's bag was empty before receiving the current cookie,
            // and now it's empty again after backtracking, it means we just tried
            // assigning a cookie to an initially empty child.
            // If there are other empty children (j > i), trying to assign this cookie to them
            // would lead to a symmetric state in terms of the distribution sums,
            // and we only care about the minimum of maximums. So we can skip them.
            // This is valid because children are distinguishable, but the problem seeks
            // the minimum of max sums, not specific assignments to specific children if they are empty.
            // Example: if childrenBags = [0,0,0] and cookie = 5.
            // Try child 0: [5,0,0]. After backtrack, [0,0,0].
            // Now, child 1 is also 0. If we try child 1: [0,5,0]. This is symmetric to [5,0,0]
            // in terms of the *set* of sums {5,0,0}.
            // This optimization is crucial for performance.
            if (childrenBags[i] == 0) { // If the child's bag became empty after backtracking
                break; // Skip trying other empty children for this cookie
            }
        }
    }
}