public class Solution {

import java.util.*;

public class Solution {
    public int kAvoidingSum(int k) {
        Set<Integer> used = new HashSet<>();
        int sum = 0;
        int num = 1;
        while (used.size() < k) {
            if (!used.contains(num)) {
                used.add(num);
                sum += num;
            }
            num++;
        }
        return sum;
    }
}
}