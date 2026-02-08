public class Solution {

import java.util.*;

public class Solution {
    public int flowerGame(int n) {
        int count = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                if ((i + j) % 2 == 1) {
                    count++;
                }
            }
        }
        return count;
    }
}
}