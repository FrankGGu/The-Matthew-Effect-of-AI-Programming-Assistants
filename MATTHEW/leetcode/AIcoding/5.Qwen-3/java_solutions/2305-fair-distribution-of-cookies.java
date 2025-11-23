public class Solution {

import java.util.*;

public class Solution {
    private int result = Integer.MAX_VALUE;

    public int distributeCookies(int[] cookies, int k) {
        Arrays.sort(cookies);
        reverseArray(cookies);
        int[] distribution = new int[k];
        backtrack(0, cookies, distribution, k);
        return result;
    }

    private void backtrack(int index, int[] cookies, int[] distribution, int k) {
        if (index == cookies.length) {
            int max = 0;
            for (int val : distribution) {
                max = Math.max(max, val);
            }
            result = Math.min(result, max);
            return;
        }

        for (int i = 0; i < k; i++) {
            if (i > 0 && distribution[i] == distribution[i - 1]) continue;
            if (distribution[i] + cookies[index] >= result) continue;
            distribution[i] += cookies[index];
            backtrack(index + 1, cookies, distribution, k);
            distribution[i] -= cookies[index];
        }
    }

    private void reverseArray(int[] array) {
        for (int i = 0; i < array.length / 2; i++) {
            int temp = array[i];
            array[i] = array[array.length - 1 - i];
            array[array.length - 1 - i] = temp;
        }
    }
}
}