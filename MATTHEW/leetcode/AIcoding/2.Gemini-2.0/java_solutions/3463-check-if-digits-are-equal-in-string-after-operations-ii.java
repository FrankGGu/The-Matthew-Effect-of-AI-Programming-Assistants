class Solution {
    public boolean check(String s) {
        int n = s.length();
        int[] cnt = new int[10];
        for (char c : s.toCharArray()) {
            cnt[c - '0']++;
        }
        int first = -1;
        for (int i = 0; i < 10; i++) {
            if (cnt[i] > 0) {
                if (first == -1) {
                    first = i;
                } else {
                    if (cnt[i] != cnt[first]) {
                        return false;
                    }
                }
            }
        }
        return true;
    }
}