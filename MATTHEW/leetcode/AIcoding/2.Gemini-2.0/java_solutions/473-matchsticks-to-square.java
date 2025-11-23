class Solution {
    public boolean makesquare(int[] matchsticks) {
        if (matchsticks == null || matchsticks.length < 4) {
            return false;
        }

        int sum = 0;
        for (int num : matchsticks) {
            sum += num;
        }

        if (sum % 4 != 0) {
            return false;
        }

        int sideLength = sum / 4;

        Arrays.sort(matchsticks);
        reverse(matchsticks);

        return canPartition(matchsticks, 0, new int[4], sideLength);
    }

    private boolean canPartition(int[] matchsticks, int index, int[] sides, int target) {
        if (index == matchsticks.length) {
            return sides[0] == target && sides[1] == target && sides[2] == target && sides[3] == target;
        }

        for (int i = 0; i < 4; i++) {
            if (sides[i] + matchsticks[index] <= target) {
                sides[i] += matchsticks[index];
                if (canPartition(matchsticks, index + 1, sides, target)) {
                    return true;
                }
                sides[i] -= matchsticks[index];
            }
        }

        return false;
    }

    private void reverse(int[] arr) {
        int i = 0, j = arr.length - 1;
        while (i < j) {
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
            i++;
            j--;
        }
    }
}