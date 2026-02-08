class Solution {
    public long maxStrength(int[] nums) {
        List<Integer> positive = new ArrayList<>();
        List<Integer> negative = new ArrayList<>();
        boolean hasZero = false;
        for (int num : nums) {
            if (num > 0) {
                positive.add(num);
            } else if (num < 0) {
                negative.add(num);
            } else {
                hasZero = true;
            }
        }
        Collections.sort(negative);
        long maxPos = 1;
        for (int num : positive) {
            maxPos *= num;
        }
        long maxNeg = 1;
        for (int i = 0; i < negative.size() / 2 * 2; i++) {
            maxNeg *= negative.get(i);
        }
        long res = maxPos * maxNeg;
        if (res > 0) {
            return res;
        } else if (positive.size() > 0) {
            return res;
        } else if (negative.size() >= 2) {
            return res;
        } else if (hasZero) {
            return 0;
        } else {
            return negative.get(0);
        }
    }
}