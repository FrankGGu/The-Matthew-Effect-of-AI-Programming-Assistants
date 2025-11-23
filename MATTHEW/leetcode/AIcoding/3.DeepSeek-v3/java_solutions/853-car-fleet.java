class Solution {
    public int carFleet(int target, int[] position, int[] speed) {
        int n = position.length;
        if (n == 0) return 0;

        double[][] cars = new double[n][2];
        for (int i = 0; i < n; i++) {
            cars[i][0] = position[i];
            cars[i][1] = (double)(target - position[i]) / speed[i];
        }

        Arrays.sort(cars, (a, b) -> Double.compare(b[0], a[0]));

        int res = 0;
        double currTime = 0;
        for (int i = 0; i < n; i++) {
            if (cars[i][1] > currTime) {
                res++;
                currTime = cars[i][1];
            }
        }

        return res;
    }
}