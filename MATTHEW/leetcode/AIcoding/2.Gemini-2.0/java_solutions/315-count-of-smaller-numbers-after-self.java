import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> countSmaller(int[] nums) {
        int n = nums.length;
        List<Integer> result = new ArrayList<>();
        Integer[] sorted = new Integer[n];
        List<Integer> sortedList = new ArrayList<>();

        for (int i = n - 1; i >= 0; i--) {
            int index = findIndex(sortedList, nums[i]);
            result.add(0, index);
            sortedList.add(index, nums[i]);
        }

        return result;
    }

    private int findIndex(List<Integer> sortedList, int target) {
        int low = 0;
        int high = sortedList.size();

        while (low < high) {
            int mid = low + (high - low) / 2;
            if (sortedList.get(mid) < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }
}