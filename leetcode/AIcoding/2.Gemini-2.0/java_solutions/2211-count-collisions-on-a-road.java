class Solution {
    public int countCollisions(String directions) {
        int n = directions.length();
        int collisions = 0;
        int left = 0;
        int right = n - 1;

        while (left < n && directions.charAt(left) == 'L') {
            left++;
        }

        while (right >= 0 && directions.charAt(right) == 'R') {
            right--;
        }

        for (int i = left; i <= right; i++) {
            if (directions.charAt(i) == 'R') {
                collisions++;
            } else if (directions.charAt(i) == 'L') {
                collisions++;
            }
        }

        return collisions;
    }
}