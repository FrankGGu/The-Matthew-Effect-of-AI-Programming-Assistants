import java.util.*;

class Solution {
    public int[] findDiagonalOrder(List<List<Integer>> nums) {
        Map<Integer, List<Integer>> diagonals = new HashMap<>();
        int size = 0;
        for (int i = 0; i < nums.size(); i++) {
            for (int j = 0; j < nums.get(i).size(); j++) {
                int diagonalIndex = i + j;
                diagonals.computeIfAbsent(diagonalIndex, k -> new ArrayList<>()).add(nums.get(i).get(j));
                size++;
            }
        }

        int[] result = new int[size];
        int index = 0;
        int diagonalIndex = 0;
        while (diagonals.containsKey(diagonalIndex)) {
            List<Integer> diagonal = diagonals.get(diagonalIndex);
            for (int i = diagonal.size() - 1; i >= 0; i--) {
                result[index++] = diagonal.get(i);
            }
            diagonalIndex++;
        }

        return result;
    }
}