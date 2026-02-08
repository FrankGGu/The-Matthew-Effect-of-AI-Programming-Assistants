import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<Integer> intersection(int[][] nums) {
        List<Integer> result = new ArrayList<>();
        if (nums == null || nums.length == 0) {
            return result;
        }

        Arrays.sort(nums[0]);
        List<Integer> firstArray = new ArrayList<>();
        for (int num : nums[0]) {
            firstArray.add(num);
        }

        for (int i = 1; i < nums.length; i++) {
            Arrays.sort(nums[i]);
            List<Integer> currentArray = new ArrayList<>();
            for (int num : nums[i]) {
                currentArray.add(num);
            }

            List<Integer> intersection = new ArrayList<>();
            int ptr1 = 0;
            int ptr2 = 0;

            while (ptr1 < firstArray.size() && ptr2 < currentArray.size()) {
                if (firstArray.get(ptr1).equals(currentArray.get(ptr2))) {
                    intersection.add(firstArray.get(ptr1));
                    ptr1++;
                    ptr2++;
                } else if (firstArray.get(ptr1) < currentArray.get(ptr2)) {
                    ptr1++;
                } else {
                    ptr2++;
                }
            }
            firstArray = intersection;
        }

        result = firstArray;
        return result;
    }
}