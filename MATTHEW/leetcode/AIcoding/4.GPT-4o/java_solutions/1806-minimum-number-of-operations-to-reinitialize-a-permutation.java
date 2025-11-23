class Solution {
    public int reinitializePermutation(int n) {
        int count = 0, perm = 1;
        while (perm != 1 || count == 0) {
            perm = perm % 2 == 0 ? perm / 2 : n / 2 + (perm - 1) / 2;
            count++;
        }
        return count;
    }
}