import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> buildArray(int[] target, int n) {
        List<String> operations = new ArrayList<>();
        int targetIndex = 0;

        for (int currentNum = 1; currentNum <= n && targetIndex < target.length; currentNum++) {
            operations.add("Push");
            if (target[targetIndex] == currentNum) {
                targetIndex++;
            } else {
                operations.add("Pop");
            }
        }
        return operations;
    }
}