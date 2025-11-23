import java.util.ArrayList;
import java.util.List;

class Solution {
    public long numWays(String s) {
        List<Integer> onesIndices = new ArrayList<>();
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                onesIndices.add(i);
            }
        }

        int totalOnes = onesIndices.size();
        int n = s.length();

        if (totalOnes % 3 != 0) {
            return 0;
        }

        if (totalOnes == 0) {
            // If there are no ones, any two split points will result in 0 ones in each part.
            // We need to choose 2 split points from n-1 possible positions.
            // The number of ways is C(n-1, 2) = (n-1) * (n-2) / 2.
            // Since n >= 3, n-1 >= 2, this formula is valid.
            return (long) (n - 1) * (n - 2) / 2;
        }

        // totalOnes is divisible by 3 and totalOnes > 0
        int targetOnes = totalOnes / 3;

        // The first cut can be placed anywhere between the (targetOnes)-th '1'
        // and the (targetOnes + 1)-th '1'.
        // The index of the targetOnes-th '1' (0-indexed list, so at index targetOnes - 1)
        int firstOneIdxForFirstPart = onesIndices.get(targetOnes - 1);
        // The index of the (targetOnes + 1)-th '1' (0-indexed list, so at index targetOnes)
        int secondOneIdxForFirstPart = onesIndices.get(targetOnes);

        // The second cut can be placed anywhere between the (2*targetOnes)-th '1'
        // and the (2*targetOnes + 1)-th '1'.
        // The index of the (2*targetOnes)-th '1' (0-indexed list, so at index 2*targetOnes - 1)
        int firstOneIdxForSecondPart = onesIndices.get(2 * targetOnes - 1);
        // The index of the (2*targetOnes + 1)-th '1' (0-indexed list, so at index 2*targetOnes)
        int secondOneIdxForSecondPart = onesIndices.get(2 * targetOnes);

        // Number of ways to make the first split
        long ways1 = secondOneIdxForFirstPart - firstOneIdxForFirstPart;
        // Number of ways to make the second split
        long ways2 = secondOneIdxForSecondPart - firstOneIdxForSecondPart;

        return ways1 * ways2;
    }
}