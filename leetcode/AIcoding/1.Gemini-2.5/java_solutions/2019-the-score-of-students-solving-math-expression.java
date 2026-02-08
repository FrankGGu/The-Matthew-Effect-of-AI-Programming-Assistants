import java.util.*;

class Solution {

    private List<Integer> nums;
    private List<Character> ops;
    private Set<Integer>[][] memo;
    private final int MAX_RESULT = 1000;

    public int scoreOfStudents(String s, int[] answers) {
        parseExpression(s);

        int N = nums.size();
        memo = new Set[N][N];

        // Calculate all possible results ignoring precedence, capped at MAX_RESULT
        Set<Integer> allPossibleResults = dp(0, N - 1);

        // Calculate the correct result with standard precedence
        int correctResult = calculateCorrectResult();

        int totalScore = 0;
        for (int studentAnswer : answers) {
            if (studentAnswer == correctResult) {
                totalScore += 5;
            } else if (allPossibleResults.contains(studentAnswer)) {
                totalScore += 2;
            }
        }

        return totalScore;
    }

    private void parseExpression(String s) {
        nums = new ArrayList<>();
        ops = new ArrayList<>();
        int i = 0;
        while (i < s.length()) {
            if (Character.isDigit(s.charAt(i))) {
                int num = 0;
                while (i < s.length() && Character.isDigit(s.charAt(i))) {
                    num = num * 10 + (s.charAt(i) - '0');
                    i++;
                }
                nums.add(num);
            } else {
                ops.add(s.charAt(i));
                i++;
            }
        }
    }

    private Set<Integer> dp(int i, int j) {
        if (memo[i][j] != null) {
            return memo[i][j];
        }

        Set<Integer> results = new HashSet<>();
        if (i == j) {
            results.add(nums.get(i));
            return memo[i][j] = results;
        }

        for (int k = i; k < j; k++) { // k is the index of the operator in ops list
            Set<Integer> leftResults = dp(i, k);
            Set<Integer> rightResults = dp(k + 1, j);
            char operator = ops.get(k);

            for (int leftVal : leftResults) {
                for (int rightVal : rightResults) {
                    int res = 0;
                    if (operator == '+') {
                        res = leftVal + rightVal;
                    } else { // operator == '*'
                        res = leftVal * rightVal;
                    }
                    if (res <= MAX_RESULT) { // Only consider results within the valid range
                        results.add(res);
                    }
                }
            }
        }
        return memo[i][j] = results;
    }

    private int calculateCorrectResult() {
        // Step 1: Process multiplications
        List<Integer> tempNums = new ArrayList<>();
        List<Character> tempOps = new ArrayList<>();

        int currentNum = nums.get(0);
        for (int i = 0; i < ops.size(); i++) {
            if (ops.get(i) == '*') {
                currentNum *= nums.get(i + 1);
            } else { // ops.get(i) == '+'
                tempNums.add(currentNum);
                tempOps.add(ops.get(i));
                currentNum = nums.get(i + 1);
            }
        }
        tempNums.add(currentNum); // Add the last number or accumulated product

        // Step 2: Process additions
        int result = tempNums.get(0);
        for (int i = 0; i < tempOps.size(); i++) {
            result += tempNums.get(i + 1);
        }
        return result;
    }
}