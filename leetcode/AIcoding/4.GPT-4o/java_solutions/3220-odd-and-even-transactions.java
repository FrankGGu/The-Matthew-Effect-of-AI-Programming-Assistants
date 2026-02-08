class Solution {
    public int oddEvenJumps(int[] A) {
        int n = A.length;
        if (n == 1) return 1;

        boolean[] oddJump = new boolean[n];
        boolean[] evenJump = new boolean[n];
        oddJump[n - 1] = true;
        evenJump[n - 1] = true;

        TreeMap<Integer, Integer> map = new TreeMap<>();
        map.put(A[n - 1], n - 1);

        for (int i = n - 2; i >= 0; i--) {
            Map.Entry<Integer, Integer> entry = map.ceilingEntry(A[i]);
            if (entry != null) {
                evenJump[i] = oddJump[entry.getValue()];
            }
            entry = map.floorEntry(A[i]);
            if (entry != null) {
                oddJump[i] = evenJump[entry.getValue()];
            }
            map.put(A[i], i);
        }

        int result = 0;
        for (boolean jump : oddJump) {
            if (jump) result++;
        }
        return result;
    }
}