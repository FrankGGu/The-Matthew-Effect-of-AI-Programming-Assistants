import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] getPower(int[] nums, int k) {
        if (nums == null || nums.length == 0 || k <= 0 || k > nums.length) {
            return new int[0];
        }

        List<Integer> resultList = new ArrayList<>();
        long currentWindowPower = 0;

        for (int i = 0; i < k; i++) {
            currentWindowPower += nums[i];
        }
        resultList.add((int) currentWindowPower);

        for (int i = k; i < nums.length; i++) {
            currentWindowPower -= nums[i - k];
            currentWindowPower += nums[i];
            resultList.add((int) currentWindowPower);
        }

        int[] finalResult = new int[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            finalResult[i] = resultList.get(i);
        }

        return finalResult;
    }
}