class Solution {
    public boolean isSelfCrossing(int[] distance) {
        int n = distance.length;

        if (n < 4) {
            return false;
        }

        for (int i = 3; i < n; i++) {
            // Case 1: The i-th line segment crosses the (i-3)-th line segment.
            // This happens when the path spirals inward.
            // Example: distance[3] (East) crosses distance[0] (North)
            if (distance[i] >= distance[i - 2] && distance[i - 1] <= distance[i - 3]) {
                return true;
            }

            // Case 2: The i-th line segment crosses the (i-4)-th line segment.
            // This happens when the path forms a closed loop, "straightening out".
            // Example: distance[4] (North) crosses distance[0] (North)
            if (i >= 4) {
                if (distance[i - 1] == distance[i - 3] && distance[i] + distance[i - 4] >= distance[i - 2]) {
                    return true;
                }
            }

            // Case 3: The i-th line segment crosses the (i-5)-th line segment.
            // This is a more complex scenario where the path spirals inward, then outward, then inward again.
            // Example: distance[5] (West) crosses distance[0] (North)
            if (i >= 5) {
                if (distance[i - 2] >= distance[i - 4] && 
                    distance[i - 1] + distance[i - 5] >= distance[i - 3] && 
                    distance[i] + distance[i - 4] >= distance[i - 2]) {
                    return true;
                }
            }
        }

        return false;
    }
}