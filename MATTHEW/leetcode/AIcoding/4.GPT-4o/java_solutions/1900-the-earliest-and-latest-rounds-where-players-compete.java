import java.util.*;

public class Solution {
    public int[] earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
        int[] result = new int[2];
        result[0] = findEarliest(n, firstPlayer, secondPlayer);
        result[1] = findLatest(n, firstPlayer, secondPlayer);
        return result;
    }

    private int findEarliest(int n, int a, int b) {
        if (a > b) {
            int temp = a;
            a = b;
            b = temp;
        }
        return (a == 1 && b == 2) ? 1 : (a + b - 1) / 2;
    }

    private int findLatest(int n, int a, int b) {
        if (a > b) {
            int temp = a;
            a = b;
            b = temp;
        }
        return n - (b - a) / 2;
    }
}