public class Solution {

import java.util.*;

public class Solution {
    public int longestWPI(boolean[] t) {
        int n = t.length;
        int[] score = new int[n];
        for (int i = 0; i < n; i++) {
            score[i] = t[i] ? 1 : -1;
        }

        Map<Integer, Integer> firstIndex = new HashMap<>();
        int res = 0;
        int balance = 0;

        for (int i = 0; i < n; i++) {
            balance += score[i];
            if (!firstIndex.containsKey(balance)) {
                firstIndex.put(balance, i);
            }
            if (balance > 0) {
                res = i + 1;
            } else {
                if (firstIndex.containsKey(balance - 1)) {
                    res = Math.max(res, i - firstIndex.get(balance - 1));
                }
            }
        }

        return res;
    }
}
}