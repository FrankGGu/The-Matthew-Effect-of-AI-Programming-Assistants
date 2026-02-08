import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int totalStrength(int[] strength) {
        int n = strength.length;
        long MOD = 1_000_000_007;

        // Step 1: Calculate prefix sums P
        // P[k] = strength[0] + ... + strength[k-1]
        // P[0] = 0
        // P stores actual sums, not modulo sums, as intermediate sums fit in long.
        long[] P = new long[n + 1];
        for (int i = 0; i < n; i++) {
            P[i + 1] = P[i] + strength[i];
        }

        // Step 2: Calculate prefix sums of prefix sums PP
        // PP[k] = P[0] + ... + P[k-1]
        // PP[0] = 0
        // PP stores actual sums, not modulo sums, as intermediate sums fit in long.
        long[] PP = new long[n + 2];
        for (int i = 0; i <= n; i++) {
            PP[i + 1] = PP[i] + P[i];
        }

        // Step 3: Find Nearest Smaller Element to the Left (L)
        // L[i] = index of the first element to the left of i that is strictly smaller than strength[i]
        // If no such element, L[i] = -1
        int[] L = new int[n];
        Deque<Integer> stack = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && strength[stack.peek()] >= strength[i]) {
                stack.pop();
            }
            L[i] = stack.isEmpty() ? -1 : stack.peek();
            stack.push(i);
        }

        // Step 4: Find Nearest Smaller or Equal Element to the Right (R)
        // R[i] = index of the first element to the right of i that is smaller or equal to strength[i]
        // If no such element, R[i] = n
        int[] R = new int[n];
        stack.clear();
        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && strength[stack.peek()] > strength[i]) {
                stack.pop();
            }
            R[i] = stack.isEmpty() ? n : stack.peek();
            stack.push(i);
        }

        // Step 5: Calculate total strength
        long totalStrength = 0;
        for (int i = 0; i < n; i++) {
            long leftBound = L[i]; // index of the element just before the subarray starts (exclusive)
            long rightBound = R[i]; // index of the element just after the subarray ends (exclusive)

            // leftLen: number of choices for the left endpoint 'l' such that L[i] < l <= i
            long leftLen = i - leftBound; 
            // rightLen: number of choices for the right endpoint 'r' such that i <= r < R[i]
            long rightLen = rightBound - i;

            // Calculate sum_{k=i+1}^{R[i]} P[k] (modulo MOD)
            // This is (PP[R[i]+1] - PP[i+1]) % MOD
            long sumPrefixRight = (PP[(int)rightBound + 1] - PP[i + 1]);
            sumPrefixRight = (sumPrefixRight % MOD + MOD) % MOD; // Ensure positive modulo

            // Calculate sum_{k=L[i]+1}^{i} P[k] (modulo MOD)
            // This is (PP[i+1] - PP[L[i]+1]) % MOD
            long sumPrefixLeft = (PP[i + 1] - PP[(int)leftBound + 1]);
            sumPrefixLeft = (sumPrefixLeft % MOD + MOD) % MOD; // Ensure positive modulo

            // Calculate the total sum of subarray sums for all subarrays where strength[i] is the minimum.
            // Formula: (leftLen * sumPrefixRight - rightLen * sumPrefixLeft) % MOD
            long term1 = (leftLen * sumPrefixRight) % MOD;
            long term2 = (rightLen * sumPrefixLeft) % MOD;
            long innerSumVal = (term1 - term2 + MOD) % MOD; // Ensure positive result

            // Multiply by strength[i] and add to total
            totalStrength = (totalStrength + (innerSumVal * strength[i]) % MOD) % MOD;
        }

        return (int) totalStrength;
    }
}