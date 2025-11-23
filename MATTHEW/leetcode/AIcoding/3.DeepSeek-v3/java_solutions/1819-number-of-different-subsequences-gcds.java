class Solution {
    public int countDifferentSubsequenceGCDs(int[] nums) {
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }
        boolean[] present = new boolean[maxNum + 1];
        for (int num : nums) {
            present[num] = true;
        }
        int count = 0;
        for (int i = 1; i <= maxNum; i++) {
            int currentGcd = 0;
            for (int j = i; j <= maxNum; j += i) {
                if (present[j]) {
                    currentGcd = gcd(currentGcd, j);
                    if (currentGcd == i) {
                        count++;
                        break;
                    }
                }
            }
        }
        return count;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}