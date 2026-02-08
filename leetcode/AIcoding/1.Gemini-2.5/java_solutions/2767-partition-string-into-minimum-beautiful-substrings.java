import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minimumBeautifulSubstrings(String s) {
        int n = s.length();

        Set<Integer> powersOf5 = new HashSet<>();
        long p = 1; // Use long to prevent overflow during multiplication before comparison
        // The maximum length of s is 15. A 15-bit binary string can represent values up to 2^15 - 1 = 32767.
        // We only need to consider powers of 5 that are less than or equal to 32767.
        // These are: 5^0=1, 5^1=5, 5^2=25, 5^3=125, 5^4=625, 5^5=3125, 5^6=15625.
        // 5^7 = 78125, which is greater than 32767.
        while (p <= 32767) { 
            powersOf5.add((int) p);
            // Check to prevent overflow before the next multiplication, though not strictly needed for 32767 limit
            if (p > Integer.MAX_VALUE / 5) { 
                break;
            }
            p *= 5;
        }

        // dp[i] will store the minimum number of beautiful substrings to partition s[i...n-1]
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[n] = 0; // Base case: 0 partitions for an empty suffix

        // Iterate from the end of the string backwards
        for (int i = n - 1; i >= 0; i--) {
            // A beautiful substring cannot start with '0' (as powers of 5 are positive and their binary
            // representations, except for "0" itself, which is not a power of 5, start with '1').
            if (s.charAt(i) == '0') {
                continue; 
            }

            int currentNum = 0;
            // Iterate from current position i to find all possible beautiful substrings starting at i
            for (int j = i; j < n; j++) {
                currentNum = currentNum * 2 + (s.charAt(j) - '0');

                // If currentNum exceeds 32767, it cannot be a relevant power of 5.
                // The powersOf5 set already implicitly handles this by only containing values up to 15625.

                if (powersOf5.contains(currentNum)) {
                    // If the rest of the string (s[j+1...n-1]) can be partitioned, update dp[i]
                    if (dp[j + 1] != Integer.MAX_VALUE) {
                        dp[i] = Math.min(dp[i], 1 + dp[j + 1]);
                    }
                }
            }
        }

        // If dp[0] is still Integer.MAX_VALUE, it means no valid partition exists
        return dp[0] == Integer.MAX_VALUE ? -1 : dp[0];
    }
}