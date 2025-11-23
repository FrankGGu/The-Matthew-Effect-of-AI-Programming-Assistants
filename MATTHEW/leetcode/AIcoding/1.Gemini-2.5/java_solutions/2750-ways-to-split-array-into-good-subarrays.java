import java.util.ArrayList;
import java.util.List;

class Solution {
    public int waysToSplitArray(int[] nums) {
        List<Integer> oneIndices = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                oneIndices.add(i);
            }
        }

        if (oneIndices.isEmpty()) {
            return 0;
        }

        if (oneIndices.size() == 1) {
            return 1;
        }

        long ways = 1;
        long MOD = 1_000_000_007;

        for (int i = 0; i < oneIndices.size() - 1; i++) {
            long diff = oneIndices.get(i + 1) - oneIndices.get(i);
            ways = (ways * diff) % MOD;
        }

        return (int) ways;
    }
}