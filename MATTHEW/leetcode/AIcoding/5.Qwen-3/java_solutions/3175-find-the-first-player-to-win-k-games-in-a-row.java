public class Solution {

import java.util.*;

public class Solution {
    public int kGames(int[] score, int k) {
        int n = score.length;
        int currentStreak = 0;
        for (int i = 0; i < n; i++) {
            if (i == 0 || score[i] > score[i - 1]) {
                currentStreak++;
            } else {
                currentStreak = 1;
            }
            if (currentStreak >= k) {
                return i;
            }
        }
        return -1;
    }
}
}