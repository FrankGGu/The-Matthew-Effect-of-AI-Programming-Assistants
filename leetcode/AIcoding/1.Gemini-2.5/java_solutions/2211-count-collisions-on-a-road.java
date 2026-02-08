class Solution {
    public int countCollisions(String directions) {
        int n = directions.length();
        if (n <= 1) {
            return 0;
        }

        // Find the index of the first car that is not 'L'
        // All 'L' cars before this index will drive off the road without colliding.
        int left = 0;
        while (left < n && directions.charAt(left) == 'L') {
            left++;
        }

        // Find the index of the last car that is not 'R'
        // All 'R' cars after this index will drive off the road without colliding.
        int right = n - 1;
        while (right >= 0 && directions.charAt(right) == 'R') {
            right--;
        }

        // If left > right, it means all cars are 'L's followed by 'R's (e.g., "LLLRRR"),
        // or all 'L's ("LLL"), or all 'R's ("RRR"), or an empty string after trimming.
        // In such cases, no collisions occur among the remaining cars.
        if (left > right) {
            return 0;
        }

        // The number of 'L' cars that escaped is `left`.
        // The number of 'R' cars that escaped is `n - 1 - right`.

        // Count all 'R' and 'L' cars in the original string.
        int totalMovingCars = 0;
        for (int i = 0; i < n; i++) {
            if (directions.charAt(i) == 'R' || directions.charAt(i) == 'L') {
                totalMovingCars++;
            }
        }

        // The total number of collisions is the count of 'R' and 'L' cars
        // that do NOT escape the road.
        // Each 'R' car that becomes stationary contributes 1 collision.
        // Each 'L' car that becomes stationary contributes 1 collision.
        // This covers R-S (1 collision), S-L (1 collision), and R-L (2 collisions).
        // 'S' cars within the collision zone act as stationary obstacles,
        // causing moving cars to stop, but they don't add an *additional* collision count
        // beyond the stopping of the 'R' or 'L' car.

        // So, we subtract the number of escaping 'L's and 'R's from the total moving cars.
        return totalMovingCars - left - (n - 1 - right);
    }
}