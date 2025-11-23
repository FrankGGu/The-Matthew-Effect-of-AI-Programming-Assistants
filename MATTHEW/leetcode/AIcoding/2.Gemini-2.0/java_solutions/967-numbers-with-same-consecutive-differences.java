class Solution {
    public int[] numsSameConsecDiff(int n, int k) {
        if (n == 1) {
            return new int[]{0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
        }

        List<Integer> result = new ArrayList<>();
        for (int i = 1; i <= 9; i++) {
            dfs(n - 1, k, i, result);
        }

        return result.stream().mapToInt(Integer::intValue).distinct().toArray();
    }

    private void dfs(int n, int k, int num, List<Integer> result) {
        if (n == 0) {
            result.add(num);
            return;
        }

        int lastDigit = num % 10;
        if (lastDigit + k <= 9) {
            dfs(n - 1, k, num * 10 + lastDigit + k, result);
        }

        if (k != 0 && lastDigit - k >= 0) {
            dfs(n - 1, k, num * 10 + lastDigit - k, result);
        }
    }
}