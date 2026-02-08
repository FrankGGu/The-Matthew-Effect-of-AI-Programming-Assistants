public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> memLeak(int n) {
        List<Integer> result = new ArrayList<>();
        int time = 1;
        while (n > 0) {
            result.add(time);
            n -= time;
            time++;
        }
        result.add(time);
        return result;
    }
}
}