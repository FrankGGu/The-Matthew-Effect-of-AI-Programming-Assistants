public class Solution {

import java.util.*;

public class Solution {
    public int[] arrangeBooks(int[] books, int k) {
        int n = books.length;
        int[] result = new int[n];
        int[] count = new int[k + 1];
        for (int book : books) {
            count[book]++;
        }
        int index = 0;
        for (int i = 1; i <= k; i++) {
            for (int j = 0; j < count[i]; j++) {
                result[index++] = i;
            }
        }
        return result;
    }
}
}