import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> buildArray(int[] target, int n) {
        List<String> operations = new ArrayList<>();
        int current = 1;
        int targetIndex = 0;
        while (targetIndex < target.length) {
            if (target[targetIndex] == current) {
                operations.add("Push");
                targetIndex++;
                current++;
            } else {
                operations.add("Push");
                operations.add("Pop");
                current++;
            }
            if (current > n) {
                break;
            }
        }
        return operations;
    }
}