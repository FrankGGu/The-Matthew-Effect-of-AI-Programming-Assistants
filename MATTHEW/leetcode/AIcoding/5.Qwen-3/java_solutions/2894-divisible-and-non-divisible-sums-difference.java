public class Solution {

import java.util.*;

public class Solution {
    public int differenceOfSums(int nums[], int k) {
        int sumDivisible = 0;
        int sumNonDivisible = 0;
        for (int num : nums) {
            if (num % k == 0) {
                sumDivisible += num;
            } else {
                sumNonDivisible += num;
            }
        }
        return sumNonDivisible - sumDivisible;
    }
}
}