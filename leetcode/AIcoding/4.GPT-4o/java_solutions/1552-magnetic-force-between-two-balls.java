class Solution {
    public int maxDistance(int[] position, int m) {
        Arrays.sort(position);
        int low = 1, high = position[position.length - 1] - position[0];
        int answer = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canPlace(position, mid, m)) {
                answer = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return answer;
    }

    private boolean canPlace(int[] position, int minDist, int m) {
        int count = 1;
        int lastPosition = position[0];

        for (int i = 1; i < position.length; i++) {
            if (position[i] - lastPosition >= minDist) {
                count++;
                lastPosition = position[i];
                if (count >= m) {
                    return true;
                }
            }
        }
        return false;
    }
}