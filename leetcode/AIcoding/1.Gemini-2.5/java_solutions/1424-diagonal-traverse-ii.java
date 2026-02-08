import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int[] findDiagonalOrder(List<List<Integer>> nums) {
        List<List<Integer>> diagonals = new ArrayList<>();

        for (int r = 0; r < nums.size(); r++) {
            for (int c = 0; c < nums.get(r).size(); c++) {
                int sum = r + c;
                while (sum >= diagonals.size()) {
                    diagonals.add(new ArrayList<>());
                }
                diagonals.get(sum).add(nums.get(r).get(c));
            }
        }

        List<Integer> resultList = new ArrayList<>();
        for (List<Integer> diagonal : diagonals) {
            Collections.reverse(diagonal);
            resultList.addAll(diagonal);
        }

        int[] finalResult = new int[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            finalResult[i] = resultList.get(i);
        }

        return finalResult;
    }
}