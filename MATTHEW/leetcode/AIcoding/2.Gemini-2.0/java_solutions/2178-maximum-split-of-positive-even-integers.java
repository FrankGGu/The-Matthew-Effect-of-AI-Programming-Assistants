import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Long> maximumEvenSplit(long finalSum) {
        List<Long> result = new ArrayList<>();
        if (finalSum % 2 != 0) {
            return result;
        }

        long currentSum = 0;
        long currentNum = 2;

        while (currentSum + currentNum <= finalSum) {
            result.add(currentNum);
            currentSum += currentNum;
            currentNum += 2;
        }

        if (currentSum < finalSum) {
            result.set(result.size() - 1, result.get(result.size() - 1) + (finalSum - currentSum));
        }

        return result;
    }
}