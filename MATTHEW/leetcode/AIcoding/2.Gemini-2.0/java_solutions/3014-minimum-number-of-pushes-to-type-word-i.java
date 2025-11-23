class Solution {
    public int minPushes(String word) {
        int n = word.length();
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (i < 8) {
                count += 1;
            } else if (i < 16) {
                count += 2;
            } else if (i < 24) {
                count += 3;
            } else {
                count += 4;
            }
        }
        return count;
    }
}