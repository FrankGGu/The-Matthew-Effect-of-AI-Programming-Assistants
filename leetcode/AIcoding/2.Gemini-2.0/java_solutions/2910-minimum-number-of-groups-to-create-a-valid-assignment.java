import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minGroupsForValidAssignment(int[] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        int n = nums.length;
        int minGroups = n;

        for (int size = 1; size <= n; size++) {
            int groups = 0;
            boolean possible = true;
            for (int count : countMap.values()) {
                int numGroups = 0;
                if (count < size) {
                    possible = false;
                    break;
                } else if (count == size) {
                    numGroups = 1;
                } else {
                    int rem = count % (size + 1);
                    int div = count / (size + 1);
                    if (rem > div) {
                        possible = false;
                        break;
                    } else {
                        numGroups = div + (rem > 0 ? 1 : 0);
                    }
                }
                groups += numGroups;
            }

            if (possible) {
                minGroups = Math.min(minGroups, groups);
            }
        }

        return minGroups;
    }
}