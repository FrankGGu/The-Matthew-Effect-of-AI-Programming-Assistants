public class Solution {

import java.util.Arrays;

public class Solution {
    public int[] fairCandySwap(int[] A, int[] B) {
        int sumA = Arrays.stream(A).sum();
        int sumB = Arrays.stream(B).sum();
        int delta = (sumB - sumA) / 2;
        boolean[] setB = new boolean[10001];
        for (int b : B) {
            setB[b] = true;
        }
        for (int a : A) {
            if (setB[a + delta]) {
                return new int[]{a, a + delta};
            }
        }
        return new int[]{};
    }
}
}