public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> buildArray(int[] target, int n) {
        List<String> result = new ArrayList<>();
        int current = 1;
        for (int num : target) {
            while (current < num) {
                result.add("Push");
                result.add("Pop");
                current++;
            }
            result.add("Push");
            current++;
        }
        return result;
    }
}
}