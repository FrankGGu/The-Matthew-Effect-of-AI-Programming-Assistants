public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> fourDivisors(int[] nums) {
        List<Integer> result = new ArrayList<>();
        for (int num : nums) {
            int count = 0;
            int sqrtNum = (int) Math.sqrt(num);
            for (int i = 1; i <= sqrtNum; i++) {
                if (num % i == 0) {
                    if (i * i == num) {
                        count++;
                    } else {
                        count += 2;
                    }
                }
            }
            if (count == 4) {
                result.add(num);
            }
        }
        return result;
    }
}
}