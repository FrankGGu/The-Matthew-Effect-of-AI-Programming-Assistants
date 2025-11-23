public class Solution {
    public int numberOfChildrenWithBall(int n, int k) {
        int[] ball = new int[n];
        int current = 0;
        for (int i = 0; i < k; i++) {
            ball[current]++;
            current = (current + 1) % n;
        }
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (ball[i] > 0) {
                count++;
            }
        }
        return count;
    }
}