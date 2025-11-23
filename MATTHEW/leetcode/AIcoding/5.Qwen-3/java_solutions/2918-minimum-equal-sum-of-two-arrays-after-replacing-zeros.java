public class Solution {

import java.util.*;

public class Solution {
    public int minEqualSum(int[] a, int[] b) {
        int sumA = 0, sumB = 0;
        int countA = 0, countB = 0;

        for (int num : a) {
            if (num == 0) {
                countA++;
            } else {
                sumA += num;
            }
        }

        for (int num : b) {
            if (num == 0) {
                countB++;
            } else {
                sumB += num;
            }
        }

        int min = Math.min(sumA, sumB);
        int max = Math.max(sumA, sumB);

        if (countA == 0 && countB == 0) {
            return sumA == sumB ? sumA : -1;
        }

        if (countA == 0) {
            if (sumA < sumB) {
                return -1;
            }
            return sumA;
        }

        if (countB == 0) {
            if (sumB < sumA) {
                return -1;
            }
            return sumB;
        }

        int diff = Math.abs(sumA - sumB);
        int totalZeros = countA + countB;

        if (diff % totalZeros != 0) {
            return -1;
        }

        int perZero = diff / totalZeros;

        if (sumA > sumB) {
            return sumA + perZero * countA;
        } else {
            return sumB + perZero * countB;
        }
    }
}
}