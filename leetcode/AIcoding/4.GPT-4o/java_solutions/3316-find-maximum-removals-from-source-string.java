class Solution {
    public int maximumRemovals(String s, String p, int[] removable) {
        int left = 0, right = removable.length, result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canForm(s, p, removable, mid)) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return result;
    }

    private boolean canForm(String s, String p, int[] removable, int k) {
        boolean[] removed = new boolean[s.length()];
        for (int i = 0; i < k; i++) {
            removed[removable[i]] = true;
        }

        int j = 0;
        for (int i = 0; i < s.length(); i++) {
            if (!removed[i] && j < p.length() && s.charAt(i) == p.charAt(j)) {
                j++;
            }
        }
        return j == p.length();
    }
}