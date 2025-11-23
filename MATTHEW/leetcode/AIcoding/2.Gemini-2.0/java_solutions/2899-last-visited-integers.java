import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] lastVisitedIntegers(List<String> words) {
        List<Integer> nums = new ArrayList<>();
        List<Integer> lastVisited = new ArrayList<>();
        int k = 0;

        for (String word : words) {
            if (word.equals("prev")) {
                k++;
                if (nums.size() - k < 0) {
                    lastVisited.add(-1);
                } else {
                    lastVisited.add(nums.get(nums.size() - k));
                }
            } else {
                nums.add(Integer.parseInt(word));
                k = 0;
            }
        }

        int[] result = new int[lastVisited.size()];
        for (int i = 0; i < lastVisited.size(); i++) {
            result[i] = lastVisited.get(i);
        }

        return result;
    }
}