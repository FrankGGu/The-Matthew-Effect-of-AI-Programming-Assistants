public class Solution {
    public int maxDistance(int[] positions, int m) {
        Arrays.sort(positions);
        int left = 0, right = positions[positions.length - 1] - positions[0];
        int answer = 0;

        while (left <= right) {
            int mid = (left + right) / 2;
            if (canPlaceBalls(positions, mid, m)) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return answer;
    }

    private boolean canPlaceBalls(int[] positions, int minDist, int m) {
        int count = 1;
        int lastPosition = positions[0];

        for (int i = 1; i < positions.length; i++) {
            if (positions[i] - lastPosition >= minDist) {
                count++;
                lastPosition = positions[i];
                if (count == m) {
                    return true;
                }
            }
        }

        return count >= m;
    }
}