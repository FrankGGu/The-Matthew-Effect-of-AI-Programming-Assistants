import java.util.HashSet;

public class Solution {
    public int countTriplets(int[] nums) {
        HashSet<Integer> uniqueTriplets = new HashSet<>();
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    if (i != j && j != k && i != k) {
                        int xorValue = nums[i] ^ nums[j] ^ nums[k];
                        uniqueTriplets.add(xorValue);
                    }
                }
            }
        }
        return uniqueTriplets.size();
    }
}