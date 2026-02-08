class Solution {
    public boolean hasGroupsSizeX(int[] deck) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : deck) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
        int gcd = -1;
        for (int count : countMap.values()) {
            if (gcd == -1) {
                gcd = count;
            } else {
                gcd = computeGCD(gcd, count);
            }
        }
        return gcd >= 2;
    }

    private int computeGCD(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}