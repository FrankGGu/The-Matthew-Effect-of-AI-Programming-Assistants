import java.util.HashSet;

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

        HashSet<Integer> gcdSet = new HashSet<>();
        for (int g = 1; g <= maxNum; g++) {
            int currentGCD = 0;
            for (int multiple = g; multiple <= maxNum; multiple += g) {
                if (present[multiple]) {
                    currentGCD = gcd(currentGCD, multiple);
                }
            }
            if (currentGCD == g) {
                gcdSet.add(g);
            }
        }

        return gcdSet.size();
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