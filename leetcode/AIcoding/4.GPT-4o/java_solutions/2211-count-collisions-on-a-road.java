class Solution {
    public int countCollisions(String directions) {
        int collisions = 0;
        char[] arr = directions.toCharArray();

        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == 'S') continue;
            if (i > 0 && arr[i] == 'L' && arr[i - 1] == 'R') {
                collisions += 2;
                arr[i] = 'S';
                arr[i - 1] = 'S';
            } 
            if (i < arr.length - 1 && arr[i] == 'R' && arr[i + 1] == 'L') {
                collisions += 2;
                arr[i] = 'S';
                arr[i + 1] = 'S';
            }
        }

        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == 'R') {
                for (int j = i + 1; j < arr.length && arr[j] != 'L'; j++) {
                    if (arr[j] == 'S') collisions++;
                }
            }
        }

        return collisions;
    }
}