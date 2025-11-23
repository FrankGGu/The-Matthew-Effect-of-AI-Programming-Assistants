class Solution {
    public int[] numsSameConsecDiff(int n, int k) {
        List<Integer> result = new ArrayList<>();
        for (int num = 1; num <= 9; num++) {
            dfs(n - 1, num, k, result);
        }
        int[] res = new int[result.size()];
        for (int i = 0; i < result.size(); i++) {
            res[i] = result.get(i);
        }
        return res;
    }

    private void dfs(int n, int num, int k, List<Integer> result) {
        if (n == 0) {
            result.add(num);
            return;
        }
        int lastDigit = num % 10;
        if (lastDigit + k <= 9) {
            dfs(n - 1, num * 10 + lastDigit + k, k, result);
        }
        if (k != 0 && lastDigit - k >= 0) {
            dfs(n - 1, num * 10 + lastDigit - k, k, result);
        }
    }
}