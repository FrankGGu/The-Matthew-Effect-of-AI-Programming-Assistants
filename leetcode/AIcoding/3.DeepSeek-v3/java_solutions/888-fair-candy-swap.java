class Solution {
    public int[] fairCandySwap(int[] A, int[] B) {
        int sumA = 0, sumB = 0;
        Set<Integer> setB = new HashSet<>();
        for (int a : A) sumA += a;
        for (int b : B) {
            sumB += b;
            setB.add(b);
        }
        int delta = (sumB - sumA) / 2;
        for (int a : A) {
            if (setB.contains(a + delta)) {
                return new int[]{a, a + delta};
            }
        }
        return new int[0];
    }
}