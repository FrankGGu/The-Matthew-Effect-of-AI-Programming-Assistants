class Solution {
    public int maximumRemovals(String s, String p, int[] removable) {
        int low = 0;
        int high = removable.length;
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(s, p, removable, mid)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    private boolean check(String s, String p, int[] removable, int k) {
        boolean[] isRemoved = new boolean[s.length()];
        for (int i = 0; i < k; i++) {
            isRemoved[removable[i]] = true;
        }

        int sPtr = 0;
        int pPtr = 0;

        while (sPtr < s.length() && pPtr < p.length()) {
            if (!isRemoved[sPtr] && s.charAt(sPtr) == p.charAt(pPtr)) {
                pPtr++;
            }
            sPtr++;
        }
        return pPtr == p.length();
    }
}