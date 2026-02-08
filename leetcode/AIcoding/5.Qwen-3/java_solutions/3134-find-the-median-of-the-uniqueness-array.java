public class Solution {

import java.util.*;

public class Solution {
    public int medianOfUniquenessArray(int[] nums) {
        Set<Integer> uniqueElements = new HashSet<>();
        for (int num : nums) {
            uniqueElements.add(num);
        }
        int[] uniqueArray = new int[uniqueElements.size()];
        int index = 0;
        for (int num : uniqueElements) {
            uniqueArray[index++] = num;
        }
        Arrays.sort(uniqueArray);
        int mid = uniqueArray.length / 2;
        return uniqueArray[mid];
    }
}
}