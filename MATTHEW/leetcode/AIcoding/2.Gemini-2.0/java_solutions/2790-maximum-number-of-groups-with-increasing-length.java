import java.util.Arrays;

class Solution {
    public int maxIncreasingGroups(List<Integer> groups) {
        Collections.sort(groups);
        long sum = 0;
        int count = 0;
        for (int groupSize : groups) {
            sum += groupSize;
            if (sum >= (long) (count + 1) * (count + 2) / 2) {
                count++;
            }
        }
        return count;
    }
}