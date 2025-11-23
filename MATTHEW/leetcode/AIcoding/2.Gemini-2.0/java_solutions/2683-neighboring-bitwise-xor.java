class Solution {
    public boolean doesValidArrayExist(int[] derived) {
        int n = derived.length;
        int first = 0;
        for (int i = 0; i < n; i++) {
            first ^= derived[i];
        }
        return first == 0;
    }
}