import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public long maxStrength(int[] nums) {
        List<Integer> positives = new ArrayList<>();
        List<Integer> negatives = new ArrayList<>();
        int zeroCount = 0;

        for (int num : nums) {
            if (num > 0) {
                positives.add(num);
            } else if (num < 0) {
                negatives.add(num);
            } else {
                zeroCount++;
            }
        }

        Collections.sort(negatives); // Sort negatives ascending: e.g., [-10, -5, -1]

        long product = 1L;
        boolean hasNonOneProductTerm = false; // Flag to indicate if any number other than 1 was included in the product, or if a 1 was included but there are other numbers.

        // Multiply all positive numbers
        for (int p : positives) {
            product *= p;
            hasNonOneProductTerm = true;
        }

        // Handle negative numbers
        if (negatives.size() % 2 == 0) {
            // Even number of negatives, multiply all of them to get a positive product
            for (int n : negatives) {
                product *= n;
                hasNonOneProductTerm = true;
            }
        } else {
            // Odd number of negatives, multiply all except the largest negative (smallest absolute value)
            // This is negatives.get(negatives.size() - 1) after sorting ascending
            // E.g., for [-5, -3, -1], we skip -1 and multiply -5 * -3
            for (int i = 0; i < negatives.size() - 1; i++) {
                product *= negatives.get(i);
                hasNonOneProductTerm = true;
            }
        }

        // Special handling for edge cases where no numbers were included in the product that would make it non-1
        // This means 'product' is still 1L from initialization, AND 'hasNonOneProductTerm' is false.
        // This occurs if:
        // 1. All numbers were zeros (positives empty, negatives empty, zeroCount > 0)
        // 2. Only one negative number and some zeros (positives empty, negatives.size() == 1, zeroCount > 0)
        // 3. Only one negative number and no zeros (positives empty, negatives.size() == 1, zeroCount == 0)

        if (hasNonOneProductTerm) {
            // If hasNonOneProductTerm is true, it means we've multiplied at least one non-zero number,
            // or a '1' that was part of a larger product. The current 'product' is valid.
            return product;
        } else {
            // If hasNonOneProductTerm is false, it means:
            // - 'positives' was empty
            // - 'negatives' was empty OR 'negatives' had size 1 (and was skipped)
            // In this scenario, the initial 'product' of 1L is not representative.

            if (zeroCount > 0) {
                // If there are any zeros, and we couldn't form a positive product
                // (because positives empty and negatives either empty or size 1),
                // then 0 is the maximum strength (better than a single negative number).
                // Examples: [0], [-5, 0], [0,0,0]
                return 0;
            } else {
                // This implies:
                // - 'positives' was empty
                // - 'negatives' had size 1 (e.g., nums = [-5])
                // - 'zeroCount' was 0
                // In this specific case, the only non-empty subsequence is the single negative number itself.
                // Example: [-5] -> result -5
                return negatives.get(0);
            }
        }
    }
}