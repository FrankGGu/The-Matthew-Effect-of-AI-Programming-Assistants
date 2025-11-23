import java.util.Arrays;

class Solution {
    public long removeBeans(int[] beans) {
        int n = beans.length;
        Arrays.sort(beans);

        long totalSum = 0;
        for (int bean : beans) {
            totalSum += bean;
        }

        long minRemovedBeans = totalSum;

        for (int i = 0; i < n; i++) {
            long currentTargetValue = beans[i];
            long numberOfBagsToKeep = n - i;

            // The sum of beans in the bags we keep, after reducing them all to currentTargetValue.
            long keptBeansSumAfterReduction = numberOfBagsToKeep * currentTargetValue;

            // The total beans removed is the initial total sum minus the beans we keep after reduction.
            long currentRemovedBeans = totalSum - keptBeansSumAfterReduction;

            minRemovedBeans = Math.min(minRemovedBeans, currentRemovedBeans);
        }

        return minRemovedBeans;
    }
}