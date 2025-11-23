import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Solution {
    public boolean canFormArray(int[] arr, int[][] pieces) {
        Map<Integer, int[]> map = new HashMap<>();
        for (int[] piece : pieces) {
            map.put(piece[0], piece);
        }

        int i = 0;
        while (i < arr.length) {
            if (!map.containsKey(arr[i])) {
                return false;
            }
            int[] piece = map.get(arr[i]);
            for (int num : piece) {
                if (i < arr.length && arr[i] == num) {
                    i++;
                } else {
                    return false;
                }
            }
        }
        return true;
    }
}