import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] separateDigits(int[] nums) {
        List<Integer> resultList = new ArrayList<>();
        for (int num : nums) {
            String numStr = String.valueOf(num);
            for (int i = 0; i < numStr.length(); i++) {
                resultList.add(Character.getNumericValue(numStr.charAt(i)));
            }
        }
        int[] result = new int[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            result[i] = resultList.get(i);
        }
        return result;
    }
}