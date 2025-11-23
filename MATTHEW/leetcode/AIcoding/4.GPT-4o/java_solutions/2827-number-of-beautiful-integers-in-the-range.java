class Solution {
    public int beautifulIntegers(int low, int high) {
        int count = 0;
        for (int i = low; i <= high; i++) {
            if (isBeautiful(i)) {
                count++;
            }
        }
        return count;
    }

    private boolean isBeautiful(int num) {
        int evenCount = 0;
        int oddCount = 0;
        while (num > 0) {
            int digit = num % 10;
            if (digit % 2 == 0) {
                evenCount++;
            } else {
                oddCount++;
            }
            num /= 10;
        }
        return evenCount > oddCount;
    }
}