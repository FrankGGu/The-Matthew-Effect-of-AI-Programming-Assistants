class Solution {
    public int maxConsecutive(int[] floors, int start, int end) {
        boolean[] special = new boolean[end - start + 1];
        for (int floor : floors) {
            if (floor >= start && floor <= end) {
                special[floor - start] = true;
            }
        }

        int maxConsecutive = 0;
        int currentConsecutive = 0;

        for (int i = 0; i < special.length; i++) {
            if (!special[i]) {
                currentConsecutive++;
            } else {
                maxConsecutive = Math.max(maxConsecutive, currentConsecutive);
                currentConsecutive = 0;
            }
        }
        maxConsecutive = Math.max(maxConsecutive, currentConsecutive);

        return maxConsecutive;
    }
}