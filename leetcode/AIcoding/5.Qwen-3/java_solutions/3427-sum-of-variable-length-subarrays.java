public class Solution {

import java.util.*;

public class Solution {
    public int sumOfSubarrays(int[] arr) {
        int n = arr.length;
        int totalSum = 0;
        for (int i = 0; i < n; i++) {
            int currentSum = 0;
            for (int j = i; j < n; j++) {
                currentSum += arr[j];
                totalSum += currentSum;
            }
        }
        return totalSum;
    }
}
}