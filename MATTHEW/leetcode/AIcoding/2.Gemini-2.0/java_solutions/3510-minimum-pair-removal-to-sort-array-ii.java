import java.util.ArrayList;
import java.util.List;

class Solution {
    public int minimumPairRemoval(int[] nums) {
        List<Integer> sorted = new ArrayList<>();
        for (int num : nums) {
            int l = 0, r = sorted.size();
            while (l < r) {
                int mid = (l + r) / 2;
                if (sorted.get(mid) <= num) {
                    l = mid + 1;
                } else {
                    r = mid;
                }
            }
            if (l < sorted.size()) {
                sorted.set(l, num);
            } else {
                sorted.add(num);
            }
        }
        return nums.length - sorted.size();
    }
}