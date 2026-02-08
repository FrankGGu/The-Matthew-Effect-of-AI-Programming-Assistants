import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> findSolution(CustomFunction customfunction, int z) {
        List<List<Integer>> result = new ArrayList<>();
        for (int x = 1; x <= 1000; x++) {
            int low = 1;
            int high = 1000;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                int val = customfunction.f(x, mid);
                if (val == z) {
                    List<Integer> solution = new ArrayList<>();
                    solution.add(x);
                    solution.add(mid);
                    result.add(solution);
                    break;
                } else if (val < z) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
        }
        return result;
    }
}