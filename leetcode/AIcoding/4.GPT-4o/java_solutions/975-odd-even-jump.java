import java.util.TreeMap;

public class Solution {
    public int oddEvenJumps(int[] A) {
        int n = A.length;
        if (n == 1) return 1;

        boolean[] oddJump = new boolean[n];
        boolean[] evenJump = new boolean[n];
        oddJump[n - 1] = evenJump[n - 1] = true;
        TreeMap<Integer, Integer> map = new TreeMap<>();
        map.put(A[n - 1], n - 1);

        for (int i = n - 2; i >= 0; i--) {
            Integer nextOdd = map.ceilingKey(A[i]);
            if (nextOdd != null) {
                oddJump[i] = evenJump[map.get(nextOdd)];
            }

            Integer nextEven = map.floorKey(A[i]);
            if (nextEven != null) {
                evenJump[i] = oddJump[map.get(nextEven)];
            }

            map.put(A[i], i);
        }

        int count = 0;
        for (boolean jump : oddJump) {
            if (jump) count++;
        }
        return count;
    }
}