import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public long countOperationsToEmptyArray(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> indexMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            indexMap.put(nums[i], i);
        }

        List<Integer> sortedNums = new ArrayList<>();
        for (int num : nums) {
            sortedNums.add(num);
        }
        sortedNums.sort(Integer::compare);

        long operations = 0;
        int current = 0;
        for (int i = 0; i < n; i++) {
            int nextIndex = indexMap.get(sortedNums.get(i));
            if (nextIndex >= current) {
                operations += (nextIndex - current);
                current = nextIndex;
            } else {
                operations += (n - current + nextIndex);
                current = nextIndex;
            }
        }

        return operations;
    }
}