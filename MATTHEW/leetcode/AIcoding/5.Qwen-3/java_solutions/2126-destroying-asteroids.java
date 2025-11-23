public class Solution {
    public boolean asteroidsDestroyed(int[] asteroids) {
        int n = asteroids.length;
        for (int i = 1; i < n; i++) {
            if (asteroids[i] > asteroids[i - 1]) {
                for (int j = i; j > 0 && asteroids[j] < asteroids[j - 1]; j--) {
                    int temp = asteroids[j];
                    asteroids[j] = asteroids[j - 1];
                    asteroids[j - 1] = temp;
                }
            }
        }
        int mass = asteroids[0];
        for (int i = 1; i < n; i++) {
            if (mass >= asteroids[i]) {
                mass += asteroids[i];
            } else {
                return false;
            }
        }
        return true;
    }
}