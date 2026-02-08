import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {

    private List<Integer> allBalancedNumbers = new ArrayList<>();

    public int nextGreaterNumericallyBalancedNumber(int n) {
        dfs(1, 0, new int[10]);

        Collections.sort(allBalancedNumbers);

        for (int num : allBalancedNumbers) {
            if (num > n) {
                return num;
            }
        }
        return -1;
    }

    private void dfs(int digit, int currentSumOfDigits, int[] counts) {
        if (currentSumOfDigits > 10) { 
            return;
        }

        if (digit == 10) { 
            if (currentSumOfDigits == 0) { 
                return;
            }

            List<Integer> digits = new ArrayList<>();
            for (int d = 1; d < 10; d++) {
                for (int i = 0; i < counts[d]; i++) {
                    digits.add(d);
                }
            }

            Collections.sort(digits);

            generatePermutations(0, digits, new boolean[digits.size()], 0L);
            return;
        }

        dfs(digit + 1, currentSumOfDigits, counts);

        if (currentSumOfDigits + digit <= 10) {
            counts[digit] = digit;
            dfs(digit + 1, currentSumOfDigits + digit, counts);
            counts[digit] = 0;
        }
    }

    private void generatePermutations(int k, List<Integer> digits, boolean[] used, long currentNum) {
        if (k == digits.size()) {
            if (currentNum > Integer.MAX_VALUE) {
                return; 
            }
            if (currentNum > 0) {
                allBalancedNumbers.add((int) currentNum);
            }
            return;
        }

        Set<Integer> seenInThisLevel = new HashSet<>();
        for (int i = 0; i < digits.size(); i++) {
            if (used[i] || seenInThisLevel.contains(digits.get(i))) {
                continue;
            }

            long nextNum = currentNum * 10 + digits.get(i);
            if (nextNum > Integer.MAX_VALUE) {
                continue;
            }

            used[i] = true;
            seenInThisLevel.add(digits.get(i));
            generatePermutations(k + 1, digits, used, nextNum);
            used[i] = false;
        }
    }
}