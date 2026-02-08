public class Solution {

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Solution {
    public List<Integer> findClosestElements(List<Integer> arr, int k) {
        int left = 0;
        int right = arr.size() - 1;
        while (right - left >= k) {
            if (arr.get(left) + arr.get(right) < 2 * arr.get((left + right) / 2)) {
                left++;
            } else {
                right--;
            }
        }
        return arr.subList(left, right + 1);
    }
}
}