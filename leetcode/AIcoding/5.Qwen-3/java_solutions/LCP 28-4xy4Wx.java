public class Solution {

import java.util.*;

public class Solution {
    public int[] dealCards(int[] cards) {
        Arrays.sort(cards);
        int n = cards.length;
        int[] result = new int[n];
        int left = 0, right = n - 1;
        boolean flag = true;
        for (int i = 0; i < n; i++) {
            if (flag) {
                result[i] = cards[left++];
            } else {
                result[i] = cards[right--];
            }
            flag = !flag;
        }
        return result;
    }
}
}