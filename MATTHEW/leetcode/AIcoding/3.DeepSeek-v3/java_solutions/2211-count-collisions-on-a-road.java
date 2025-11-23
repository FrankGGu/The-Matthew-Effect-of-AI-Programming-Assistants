class Solution {
    public int countCollisions(String directions) {
        int collisions = 0;
        char[] dirs = directions.toCharArray();
        int n = dirs.length;
        int left = 0;
        int right = n - 1;

        while (left < n && dirs[left] == 'L') {
            left++;
        }

        while (right >= 0 && dirs[right] == 'R') {
            right--;
        }

        for (int i = left; i <= right; i++) {
            if (dirs[i] != 'S') {
                collisions++;
            }
        }

        return collisions;
    }
}