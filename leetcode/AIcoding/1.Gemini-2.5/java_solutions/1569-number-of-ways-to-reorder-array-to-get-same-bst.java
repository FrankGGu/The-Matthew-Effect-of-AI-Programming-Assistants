import java.util.ArrayList;
import java.util.List;

class Solution {
    long[][] combinations;
    long MOD = 1_000_000_007;

    public int numOfWays(int[] nums) {
        int n = nums.length;
        precomputeCombinations(n);

        List<Integer> numList = new ArrayList<>();
        for (int num : nums) {
            numList.add(num);
        }

        long result = solve(numList);
        return (int) result;
    }

    void precomputeCombinations(int n) {
        combinations = new long[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            combinations[i][0] = 1;
            for (int j = 1; j <= i; j++) {
                combinations[i][j] = (combinations[i - 1][j - 1] + combinations[i - 1][j]) % MOD;
            }
        }
    }

    long solve(List<Integer> nums) {
        if (nums.size() <= 2) {
            return 1;
        }

        int root = nums.get(0);
        List<Integer> leftSubtree = new ArrayList<>();
        List<Integer> rightSubtree = new ArrayList<>();

        for (int i = 1; i < nums.size(); i++) {
            if (nums.get(i) < root) {
                leftSubtree.add(nums.get(i));
            } else {
                rightSubtree.add(nums.get(i));
            }
        }

        long waysLeft = solve(leftSubtree);
        long waysRight = solve(rightSubtree);

        int L = leftSubtree.size();
        int R = rightSubtree.size();

        long totalWays = (combinations[L + R][L] * waysLeft) % MOD;
        totalWays = (totalWays * waysRight) % MOD;

        return totalWays;
    }
}