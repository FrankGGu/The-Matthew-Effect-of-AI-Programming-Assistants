import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;

class Solution {
    public long[] getDistinctPower(int[] nums, int k) {
        int n = nums.length;
        HashMap<Integer, Integer> counts = new HashMap<>();
        long currentPower = 0;
        List<Long> resultList = new ArrayList<>();

        for (int i = 0; i < k; i++) {
            int num = nums[i];
            if (counts.getOrDefault(num, 0) == 0) {
                currentPower += num;
            }
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }
        resultList.add(currentPower);

        for (int i = k; i < n; i++) {
            int leftNum = nums[i - k];
            counts.put(leftNum, counts.get(leftNum) - 1);
            if (counts.get(leftNum) == 0) {
                currentPower -= leftNum;
            }

            int rightNum = nums[i];
            if (counts.getOrDefault(rightNum, 0) == 0) {
                currentPower += rightNum;
            }
            counts.put(rightNum, counts.getOrDefault(rightNum, 0) + 1);

            resultList.add(currentPower);
        }

        long[] powers = new long[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            powers[i] = resultList.get(i);
        }
        return powers;
    }
}