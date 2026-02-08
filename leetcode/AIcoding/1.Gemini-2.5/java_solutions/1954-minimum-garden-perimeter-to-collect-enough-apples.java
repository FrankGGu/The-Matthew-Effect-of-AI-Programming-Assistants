class Solution {
    public long minimumPerimeter(long neededApples) {
        long k = 0;
        long collectedApples = 0;

        while (collectedApples < neededApples) {
            k++;
            collectedApples = 2L * k * (k + 1) * (2 * k + 1);
        }

        return 8L * k;
    }
}