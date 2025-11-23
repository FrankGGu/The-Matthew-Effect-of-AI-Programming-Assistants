import java.util.ArrayList;
import java.util.List;

class Solution {
    private static final double EPSILON = 1e-6;

    public boolean judgePoint24(int[] cards) {
        List<Double> nums = new ArrayList<>();
        for (int card : cards) {
            nums.add((double) card);
        }
        return solve(nums);
    }

    private boolean solve(List<Double> nums) {
        if (nums.size() == 1) {
            return Math.abs(nums.get(0) - 24.0) < EPSILON;
        }

        for (int i = 0; i < nums.size(); i++) {
            for (int j = i + 1; j < nums.size(); j++) {
                List<Double> nextNums = new ArrayList<>();
                for (int k = 0; k < nums.size(); k++) {
                    if (k != i && k != j) {
                        nextNums.add(nums.get(k));
                    }
                }

                double num1 = nums.get(i);
                double num2 = nums.get(j);

                // Addition
                nextNums.add(num1 + num2);
                if (solve(nextNums)) return true;
                nextNums.remove(nextNums.size() - 1);

                // Subtraction (num1 - num2)
                nextNums.add(num1 - num2);
                if (solve(nextNums)) return true;
                nextNums.remove(nextNums.size() - 1);

                // Subtraction (num2 - num1)
                nextNums.add(num2 - num1);
                if (solve(nextNums)) return true;
                nextNums.remove(nextNums.size() - 1);

                // Multiplication
                nextNums.add(num1 * num2);
                if (solve(nextNums)) return true;
                nextNums.remove(nextNums.size() - 1);

                // Division (num1 / num2)
                if (Math.abs(num2) > EPSILON) {
                    nextNums.add(num1 / num2);
                    if (solve(nextNums)) return true;
                    nextNums.remove(nextNums.size() - 1);
                }

                // Division (num2 / num1)
                if (Math.abs(num1) > EPSILON) {
                    nextNums.add(num2 / num1);
                    if (solve(nextNums)) return true;
                    nextNums.remove(nextNums.size() - 1);
                }
            }
        }
        return false;
    }
}