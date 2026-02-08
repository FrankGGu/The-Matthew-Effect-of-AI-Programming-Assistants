public class Solution {

import java.util.*;

public class Solution {
    public int numberOfWays(String corridor) {
        int MOD = 1000000007;
        List<Integer> positions = new ArrayList<>();
        for (int i = 0; i < corridor.length(); i++) {
            if (corridor.charAt(i) == 'S') {
                positions.add(i);
            }
        }
        if (positions.size() % 2 != 0 || positions.size() < 2) {
            return 0;
        }
        int result = 1;
        for (int i = 2; i < positions.size(); i += 2) {
            int prev = positions.get(i - 1);
            int curr = positions.get(i);
            result = (result * (curr - prev)) % MOD;
        }
        return result;
    }
}
}