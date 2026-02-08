import java.util.HashMap;
import java.util.Map;

class Solution {
    public int countSubsequences(int[] nums) {
        int n = nums.length;
        int count = 0;

        for (int i = 0; i < (1 << n); i++) {
            if (Integer.bitCount(i) >= 1) {
                int[] subsequence = new int[Integer.bitCount(i)];
                int index = 0;
                for (int j = 0; j < n; j++) {
                    if ((i >> j) % 2 == 1) {
                        subsequence[index++] = nums[j];
                    }
                }

                if (subsequence.length % 2 != 0) {
                    int middle = subsequence.length / 2;
                    Map<Integer, Integer> freq = new HashMap<>();
                    for (int num : subsequence) {
                        freq.put(num, freq.getOrDefault(num, 0) + 1);
                    }

                    boolean uniqueMiddle = true;
                    for (Map.Entry<Integer, Integer> entry : freq.entrySet()) {
                        if (entry.getKey() != subsequence[middle] && entry.getValue() >= freq.get(subsequence[middle])) {
                            uniqueMiddle = false;
                            break;
                        }
                    }

                    if (uniqueMiddle) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
}