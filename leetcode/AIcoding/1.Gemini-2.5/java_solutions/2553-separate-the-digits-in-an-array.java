import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] separateDigits(int[] nums) {
        List<Integer> resultList = new ArrayList<>();
        for (int num : nums) {
            String s = String.valueOf(num);
            for (char c : s.toCharArray()) {
                resultList.add(Character.getNumericValue(c));
            }
        }

        int[] ans = new int[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            ans[i] = resultList.get(i);
        }
        return ans;
    }
}