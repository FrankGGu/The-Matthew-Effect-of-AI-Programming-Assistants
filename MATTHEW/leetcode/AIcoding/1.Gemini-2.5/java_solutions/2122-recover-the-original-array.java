import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] recoverArray(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;

        for (int j = 1; j < n; j++) {
            int kCandidate = nums[j] - nums[0];

            if (kCandidate <= 0 || kCandidate % 2 != 0) {
                continue;
            }

            Map<Integer, Integer> freq = new HashMap<>();
            for (int num : nums) {
                freq.put(num, freq.getOrDefault(num, 0) + 1);
            }

            List<Integer> lowArrayCandidate = new ArrayList<>();
            boolean possible = true;

            for (int num : nums) {
                if (freq.getOrDefault(num, 0) > 0) {
                    freq.put(num, freq.get(num) - 1);

                    int targetHigh = num + kCandidate;
                    if (freq.getOrDefault(targetHigh, 0) > 0) {
                        freq.put(targetHigh, freq.get(targetHigh) - 1);
                        lowArrayCandidate.add(num);
                    } else {
                        possible = false;
                        break;
                    }
                }
            }

            if (possible && lowArrayCandidate.size() == n / 2) {
                int[] result = new int[n / 2];
                for (int i = 0; i < n / 2; i++) {
                    result[i] = lowArrayCandidate.get(i);
                }
                return result;
            }
        }
        return new int[0];
    }
}