import java.util.ArrayList;
import java.util.List;

class Solution {
    public int waysToSplitArray(int[] nums) {
        List<Integer> onesIndices = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                onesIndices.add(i);
            }
        }

        if (onesIndices.isEmpty()) {
            return 0;
        }

        long ans = 1;
        long MOD = 1_000_000_007;

        // If there's only one '1', the only way is to consider the entire array as one good subarray.
        // In this case, onesIndices.size() - 1 will be 0, so the loop won't execute,
        // and 'ans' will remain 1, which is the correct result for this case.

        for (int i = 0; i < onesIndices.size() - 1; i++) {
            long p_i = onesIndices.get(i);
            long p_i_plus_1 = onesIndices.get(i + 1);

            // For each pair of consecutive '1's at indices p_i and p_{i+1},
            // we need to determine how many ways we can handle the segment between them.
            // This segment is nums[p_i ... p_{i+1}].
            // The choices are:
            // 1. Don't split this segment (p_i and p_{i+1} are in the same subarray). This is 1 way.
            // 2. Split within the zeros between p_i and p_{i+1}.
            //    The number of zeros is (p_{i+1} - p_i - 1).
            //    We can split after any of these zeros. This gives (p_{i+1} - p_i - 1) ways.
            // Total choices for this segment = 1 + (p_{i+1} - p_i - 1) = p_{i+1} - p_i.
            // These choices are independent for each pair of consecutive '1's.
            ans = (ans * (p_i_plus_1 - p_i)) % MOD;
        }

        return (int) ans;
    }
}