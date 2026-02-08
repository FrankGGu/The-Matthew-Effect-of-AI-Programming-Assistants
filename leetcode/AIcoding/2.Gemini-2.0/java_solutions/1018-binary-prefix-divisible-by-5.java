import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Boolean> prefixesDivBy5(int[] A) {
        List<Boolean> result = new ArrayList<>();
        int num = 0;
        for (int bit : A) {
            num = ((num << 1) + bit) % 5;
            result.add(num == 0);
        }
        return result;
    }
}