class Solution {
public:
    int countCollisions(string directions) {
        int collisions = 0;
        int n = directions.size();

        for (int i = 0; i < n; i++) {
            if (directions[i] == 'S') continue;
            if (i > 0 && directions[i] == 'L' && directions[i - 1] == 'R') {
                collisions += 2;
                directions[i] = 'S';
                directions[i - 1] = 'S';
            }
            if (i < n - 1 && directions[i] == 'R' && directions[i + 1] == 'L') {
                collisions += 2;
                directions[i] = 'S';
                directions[i + 1] = 'S';
            }
        }

        for (char dir : directions) {
            if (dir == 'S') collisions++;
        }

        return collisions;
    }
};