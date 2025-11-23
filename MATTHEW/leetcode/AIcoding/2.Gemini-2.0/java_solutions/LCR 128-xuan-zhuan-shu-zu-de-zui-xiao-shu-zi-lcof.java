import java.util.Arrays;

class Solution {
    public boolean check(String[] warehouse, String[] boxes) {
        Arrays.sort(warehouse);
        Arrays.sort(boxes);

        int boxIndex = 0;
        for (int i = 0; i < warehouse.length && boxIndex < boxes.length; i++) {
            if (Integer.parseInt(warehouse[i]) >= Integer.parseInt(boxes[boxIndex])) {
                boxIndex++;
            }
        }

        return boxIndex == boxes.length;
    }
}