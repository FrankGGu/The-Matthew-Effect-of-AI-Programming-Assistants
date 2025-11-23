import java.util.HashSet;

public class Solution {
    public int[] fairCandySwap(int[] A, int[] B) {
        int sumA = 0, sumB = 0;
        for (int x : A) sumA += x;
        for (int x : B) sumB += x;
        int target = (sumA - sumB) / 2;
        HashSet<Integer> setB = new HashSet<>();
        for (int x : B) setB.add(x);
        for (int x : A) {
            if (setB.contains(x - target)) {
                return new int[] {x, x - target};
            }
        }
        return new int[0];
    }
}