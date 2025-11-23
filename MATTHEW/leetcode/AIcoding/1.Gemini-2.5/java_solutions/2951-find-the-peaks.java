import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> findPeaks(int[] nums) {
        List<Integer> peaks = new ArrayList<>();
        for (int i = 1; i < nums.length - 1; i++) {
            if (nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) {
                peaks.add(i);
            }
        }
        return peaks;
    }
}