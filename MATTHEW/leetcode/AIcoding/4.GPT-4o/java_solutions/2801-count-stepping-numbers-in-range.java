class Solution {
    public int countSteppingNumbers(String low, String high) {
        long lowNum = Long.parseLong(low);
        long highNum = Long.parseLong(high);
        int count = 0;

        for (long i = 0; i <= 9; i++) {
            count += dfs(i, lowNum, highNum);
        }

        return count;
    }

    private int dfs(long num, long low, long high) {
        if (num > high) return 0;
        if (num >= low && num != 0) return 1;
        int count = 0;
        long lastDigit = num % 10;

        if (lastDigit > 0) {
            count += dfs(num * 10 + (lastDigit - 1), low, high);
        }
        if (lastDigit < 9) {
            count += dfs(num * 10 + (lastDigit + 1), low, high);
        }

        return count;
    }
}