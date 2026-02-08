public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums, int target) {
        int operations = 0;
        int[] count = new int[32];
        for (int num : nums) {
            for (int i = 0; i < 32; i++) {
                if ((num >> i) % 2 == 1) {
                    count[i]++;
                }
            }
        }

        for (int i = 0; i < 32 && target > 0; i++) {
            int bit = (target >> i) % 2;
            if (bit == 1) {
                if (count[i] > 0) {
                    count[i]--;
                } else {
                    int j = i + 1;
                    while (j < 32 && count[j] == 0) {
                        j++;
                    }
                    if (j == 32) {
                        return -1;
                    }
                    for (int k = j; k > i; k--) {
                        count[k]--;
                        count[k - 1]++;
                    }
                    count[i]--;
                    operations += j - i;
                }
            }
            if (i < 31) {
                count[i + 1] += count[i] / 2;
            }
            target -= bit * (1 << i);
        }

        return operations;
    }
}
}