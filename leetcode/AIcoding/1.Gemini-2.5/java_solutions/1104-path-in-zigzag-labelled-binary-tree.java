import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public List<Integer> pathInZigZagTree(int label) {
        List<Integer> path = new ArrayList<>();
        int current = label;

        int r = 0;
        int temp = label;
        while (temp > 0) {
            temp /= 2;
            r++;
        }

        while (current != 0) {
            path.add(current);

            if (current == 1) {
                break;
            }

            int leftBound = 1 << (r - 1);
            int rightBound = (1 << r) - 1;

            int standardVal;
            if (r % 2 == 1) {
                standardVal = current;
            } else {
                standardVal = leftBound + rightBound - current;
            }

            int standardParentVal = standardVal / 2;

            r--;

            int parentLeftBound = 1 << (r - 1);
            int parentRightBound = (1 << r) - 1;

            if (r % 2 == 1) {
                current = standardParentVal;
            } else {
                current = parentLeftBound + parentRightBound - standardParentVal;
            }
        }

        Collections.reverse(path);
        return path;
    }
}