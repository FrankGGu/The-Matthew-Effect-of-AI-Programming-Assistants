class Solution {
    public boolean asteroidsDestroyed(int mass, int[] asteroids) {
        long totalMass = mass;
        Arrays.sort(asteroids);
        for (int asteroid : asteroids) {
            if (totalMass < asteroid) {
                return false;
            }
            totalMass += asteroid;
        }
        return true;
    }
}