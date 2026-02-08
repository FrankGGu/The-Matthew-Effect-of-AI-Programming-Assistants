import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> findKdistantIndices(int[] nums, int key, int k) {
        List<Integer> result = new ArrayList<>();

        List<Integer> keyIndices = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == key) {
                keyIndices.add(i);
            }
        }

        boolean[] isKDist = new boolean[nums.length];

        for (int i : keyIndices) {
            int start = Math.max(0, i - k);
            int end = Math.min(nums.length - 1, i + k);

            for (int j = start; j <= end; j++) {
                isKDist[j] = true;
            }
        }

        for (int j = 0; j < nums.length; j++) {
            if (isKDist[j]) {
                result.add(j);
            }
        }

        return result;
    }
}