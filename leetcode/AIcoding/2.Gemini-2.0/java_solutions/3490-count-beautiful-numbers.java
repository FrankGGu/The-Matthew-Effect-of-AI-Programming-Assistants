class Solution {
    private int[] primes = {2, 3, 5, 7};
    private int count;

    public int countBeautifulNumbers(int low, int high) {
        return countBeautifulNumbers(high) - countBeautifulNumbers(low - 1);
    }

    private int countBeautifulNumbers(int num) {
        count = 0;
        String s = String.valueOf(num);
        int n = s.length();
        dfs(s, n, 0, 1);
        return count;
    }

    private void dfs(String s, int n, int index, long product) {
        if (index == n) {
            count++;
            return;
        }

        for (int i = index; i < n; i++) {
            String sub = s.substring(index, i + 1);
            long num = Long.parseLong(sub);
            if (isValid(num) && product <= Long.parseLong(s)) {
                dfs(s, n, i + 1, product * num);
            }
        }
    }

    private boolean isValid(long num) {
        if (num == 0) return false;
        for (int prime : primes) {
            if (num % prime == 0) return true;
        }
        return false;
    }
}