import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Boolean> prefixesDivBy5(int[] A) {
        List<Boolean> result = new ArrayList<>();
        int currentNum = 0;
        for (int num : A) {
            currentNum = (currentNum * 2 + num) % 5;
            result.add(currentNum == 0);
        }
        return result;
    }
}