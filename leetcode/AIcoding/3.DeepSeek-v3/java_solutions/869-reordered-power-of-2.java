class Solution {
    public boolean reorderedPowerOf2(int N) {
        int[] countN = countDigits(N);
        for (int i = 0; i < 31; i++) {
            int power = 1 << i;
            int[] countPower = countDigits(power);
            if (Arrays.equals(countN, countPower)) {
                return true;
            }
        }
        return false;
    }

    private int[] countDigits(int num) {
        int[] count = new int[10];
        while (num > 0) {
            count[num % 10]++;
            num /= 10;
        }
        return count;
    }
}