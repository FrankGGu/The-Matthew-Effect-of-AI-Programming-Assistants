class Solution {
    public int maxRemovableCharacters(String s, String p, String removable) {
        int left = 0, right = removable.length();
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canForm(s, p, removable, mid)) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    private boolean canForm(String s, String p, String removable, int k) {
        boolean[] removed = new boolean[removable.length()];
        for (int i = 0; i < k; i++) {
            removed[i] = true;
        }
        return isSubsequence(s, p, removed);
    }

    private boolean isSubsequence(String s, String p, boolean[] removed) {
        int j = 0;
        for (int i = 0; i < s.length(); i++) {
            if (j < p.length() && !removed[findIndex(removable, s.charAt(i))]) {
                if (s.charAt(i) == p.charAt(j)) {
                    j++;
                }
            }
        }
        return j == p.length();
    }

    private int findIndex(String removable, char c) {
        for (int i = 0; i < removable.length(); i++) {
            if (removable.charAt(i) == c) {
                return i;
            }
        }
        return -1;
    }
}