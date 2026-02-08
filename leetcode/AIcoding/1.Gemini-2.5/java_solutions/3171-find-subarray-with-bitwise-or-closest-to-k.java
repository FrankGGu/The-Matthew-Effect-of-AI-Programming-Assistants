import java.util.HashSet;
import java.util.Set;

class Solution {
    public int closestToTarget(int[] nums, int k) {
        int minDiff = Integer.MAX_VALUE;
        Set<Integer> currentORs = new HashSet<>();

        for (int num : nums) {
            Set<Integer> newORs = new HashSet<>();
            newORs.add(num); 

            for (int prevOR : currentORs) {
                newORs.add(prevOR | num);
            }

            currentORs = newORs;

            for (int orVal : currentORs) {
                minDiff = Math.min(minDiff, Math.abs(orVal - k));
            }
        }

        return minDiff;
    }
}