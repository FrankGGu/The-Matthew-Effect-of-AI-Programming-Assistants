public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int uniqueXOR(int[] nums) {
        Set<Integer> xorSet = new HashSet<>();
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                for (int k = j + 1; k < n; k++) {
                    int xor = nums[i] ^ nums[j] ^ nums[k];
                    xorSet.add(xor);
                }
            }
        }
        return xorSet.size();
    }
}
}