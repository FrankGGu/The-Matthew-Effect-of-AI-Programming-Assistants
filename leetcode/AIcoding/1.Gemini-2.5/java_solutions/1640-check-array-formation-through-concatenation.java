import java.util.HashMap;
import java.util.Map;

class Solution {
    public boolean canFormArray(int[] arr, int[][] pieces) {
        Map<Integer, int[]> pieceMap = new HashMap<>();
        for (int[] piece : pieces) {
            pieceMap.put(piece[0], piece);
        }

        int i = 0;
        while (i < arr.length) {
            if (!pieceMap.containsKey(arr[i])) {
                return false;
            }

            int[] currentPiece = pieceMap.get(arr[i]);
            for (int j = 0; j < currentPiece.length; j++) {
                if (arr[i + j] != currentPiece[j]) {
                    return false;
                }
            }
            i += currentPiece.length;
        }

        return true;
    }
}