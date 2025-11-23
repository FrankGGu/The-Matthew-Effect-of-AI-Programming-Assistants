public class Solution {

import java.util.*;

public class Solution {
    public int countTriplets(int[] A) {
        int n = A.length;
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                for (int k = j + 1; k < n; k++) {
                    if ((A[i] & A[j] & A[k]) == 0) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}
}