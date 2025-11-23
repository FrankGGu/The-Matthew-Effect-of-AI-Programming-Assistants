class Solution {
    public int countKReductionNumbers(int n, int k) {
        int count = 0;
        for (int i = 1; i < n; i++) {
            if (isKReducible(i, k)) {
                count++;
            }
        }
        return count;
    }

    private boolean isKReducible(int num, int k) {
        while (num >= 10) {
            num = getNext(num);
            if (num >= k) {
                return false;
            }
        }
        return num < k;
    }

    private int getNext(int num) {
        int nextNum = 0;
        String s = Integer.toString(num);
        for (int i = 1; i < s.length(); i++) {
            int digit1 = s.charAt(i - 1) - '0';
            int digit2 = s.charAt(i) - '0';
            nextNum = nextNum * 10 + Math.abs(digit1 - digit2);
        }
        return nextNum;
    }
}