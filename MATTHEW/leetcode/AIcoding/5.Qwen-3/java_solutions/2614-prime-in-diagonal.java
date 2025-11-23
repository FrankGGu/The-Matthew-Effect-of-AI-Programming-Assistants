public class Solution {

import java.util.*;

public class Solution {
    public int diagonalPrime(int[][] nums) {
        int max = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            int num = nums[i][i];
            if (isPrime(num) && num > max) {
                max = num;
            }
            num = nums[i][n - 1 - i];
            if (isPrime(num) && num > max) {
                max = num;
            }
        }
        return max;
    }

    private boolean isPrime(int num) {
        if (num < 2) {
            return false;
        }
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }
}
}