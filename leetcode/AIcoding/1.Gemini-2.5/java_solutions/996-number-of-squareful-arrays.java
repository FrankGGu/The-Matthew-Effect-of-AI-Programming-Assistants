import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    private int count;
    private int[] nums;
    private boolean[] used;

    public int numSquarefulPerms(int[] A) {
        Arrays.sort(A);
        this.nums = A;
        this.count = 0;
        this.used = new boolean[A.length];

        backtrack(new ArrayList<>());

        return count;
    }

    private void backtrack(List<Integer> currentPermutation) {
        if (currentPermutation.size() == nums.length) {
            count++;
            return;
        }

        for (int i = 0; i < nums.length; i++) {
            if (used[i]) {
                continue;
            }

            if (i > 0 && nums[i] == nums[i-1] && !used[i-1]) {
                continue;
            }

            if (!currentPermutation.isEmpty()) {
                int lastElement = currentPermutation.get(currentPermutation.size() - 1);
                if (!isPerfectSquare(lastElement + nums[i])) {
                    continue;
                }
            }

            used[i] = true;
            currentPermutation.add(nums[i]);
            backtrack(currentPermutation);
            currentPermutation.remove(currentPermutation.size() - 1);
            used[i] = false;
        }
    }

    private boolean isPerfectSquare(int n) {
        int s = (int) Math.sqrt(n);
        return s * s == n;
    }
}