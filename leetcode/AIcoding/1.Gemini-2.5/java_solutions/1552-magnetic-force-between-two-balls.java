import java.util.Arrays;

class Solution {
    public int maxDistance(int[] position, int m) {
        Arrays.sort(position);
        int n = position.length;

        int low = 1;
        int high = position[n - 1] - position[0];
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canPlace(position, m, mid)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    private boolean canPlace(int[] position, int m, int force) {
        int count = 1;
        int lastPlacedPosition = position[0];

        for (int i = 1; i < position.length; i++) {
            if (position[i] - lastPlacedPosition >= force) {
                count++;
                lastPlacedPosition = position[i];
            }
        }
        return count >= m;
    }
}