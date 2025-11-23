import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] distributeElements(int[] nums, int k) {
        int n = nums.length;
        int[] ans = new int[n];
        List<Integer> arr1 = new ArrayList<>();
        List<Integer> arr2 = new ArrayList<>();
        int i1 = 0, i2 = 0;
        for (int num : nums) {
            if (arr1.size() < k || arr2.size() < k) {
                if (arr1.size() < k) {
                    arr1.add(num);
                    ans[i1++] = num;
                } else {
                    arr2.add(num);
                    ans[i1++] = num;
                }
            } else {
                if (arr1.get(arr1.size() - k) <= num) {
                    arr1.add(num);
                    ans[i1++] = num;
                } else {
                    arr2.add(num);
                    ans[i1++] = num;
                }
            }
        }
        return ans;
    }
}