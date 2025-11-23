import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Long> maximumEvenSplit(long finalSum) {
        if (finalSum % 2 != 0) {
            return new ArrayList<>();
        }

        List<Long> result = new ArrayList<>();
        long currentSum = 0;
        long currentEven = 2;

        while (finalSum - currentSum >= currentEven) {
            result.add(currentEven);
            currentSum += currentEven;
            currentEven += 2;
        }

        long remainder = finalSum - currentSum;

        if (remainder > 0) {
            // Add the remainder to the last element to maintain uniqueness and maximize count.
            // The last element is the largest, so adding remainder to it will keep it unique
            // and larger than all previous elements.
            long lastElement = result.remove(result.size() - 1);
            result.add(lastElement + remainder);
        }

        return result;
    }
}