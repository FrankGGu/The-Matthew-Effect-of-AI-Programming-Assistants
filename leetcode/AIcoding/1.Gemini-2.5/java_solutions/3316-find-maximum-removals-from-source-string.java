class Solution {
    private String s;
    private String p;
    private int[] removable;
    private int sLen;
    private int pLen;

    public int maximumRemovals(String s, String p, int[] removable) {
        this.s = s;
        this.p = p;
        this.removable = removable;
        this.sLen = s.length();
        this.pLen = p.length();

        int low = 0;
        int high = removable.length;
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    private boolean check(int k) {
        boolean[] removed = new boolean[sLen];
        for (int i = 0; i < k; i++) {
            removed[removable[i]] = true;
        }

        int sPtr = 0;
        int pPtr = 0;

        while (sPtr < sLen && pPtr < pLen) {
            if (!removed[sPtr] && s.charAt(sPtr) == p.charAt(pPtr)) {
                pPtr++;
            }
            sPtr++;
        }
        return pPtr == pLen;
    }
}