public class Solution {

import java.util.*;

public class Solution {
    public int[] revealCardsInIncreasingOrder(int[] deck) {
        Arrays.sort(deck);
        int n = deck.length;
        int[] result = new int[n];
        boolean[] used = new boolean[n];
        int index = 0;
        int count = 0;

        while (count < n) {
            for (int i = 0; i < n; i++) {
                if (!used[i]) {
                    if (count == n - 1) {
                        result[i] = deck[count];
                    } else {
                        result[i] = deck[index++];
                    }
                    used[i] = true;
                    count++;
                    break;
                }
            }
        }
        return result;
    }
}
}