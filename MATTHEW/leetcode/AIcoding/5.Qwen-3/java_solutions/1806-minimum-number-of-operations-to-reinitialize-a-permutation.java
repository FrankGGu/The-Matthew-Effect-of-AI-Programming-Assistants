public class Solution {

import java.util.*;

public class Solution {
    public int oddEvenGame(int n) {
        int[] perm = new int[n];
        for (int i = 0; i < n; i++) {
            perm[i] = i + 1;
        }

        int operations = 0;
        boolean isOddTurn = true;

        while (true) {
            boolean changed = false;
            for (int i = 0; i < n; i++) {
                if (isOddTurn && i % 2 == 1 && perm[i] > perm[i - 1]) {
                    int temp = perm[i];
                    perm[i] = perm[i - 1];
                    perm[i - 1] = temp;
                    changed = true;
                } else if (!isOddTurn && i % 2 == 0 && perm[i] > perm[i - 1]) {
                    int temp = perm[i];
                    perm[i] = perm[i - 1];
                    perm[i - 1] = temp;
                    changed = true;
                }
            }
            if (!changed) {
                break;
            }
            operations++;
            isOddTurn = !isOddTurn;
        }

        return operations;
    }
}
}