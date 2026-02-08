public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public boolean isCircularArrayLoop(int[] nums) {
        int n = nums.length;
        Set<Integer> visited = new HashSet<>();

        for (int i = 0; i < n; i++) {
            if (visited.contains(i)) continue;
            Set<Integer> set = new HashSet<>();
            int j = i;
            boolean direction = nums[j] > 0;
            while (true) {
                if (visited.contains(j)) {
                    if (set.contains(j)) {
                        return true;
                    } else {
                        break;
                    }
                }
                if (nums[j] > 0 != direction) {
                    break;
                }
                visited.add(j);
                set.add(j);
                j = (j + nums[j] + n) % n;
            }
        }
        return false;
    }
}
}