import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> grayCode(int n) {
        List<Integer> result = new ArrayList<>();
        result.add(0);

        for (int i = 0; i < n; i++) {
            int currentSize = result.size();
            int leadingBit = 1 << i;
            for (int j = currentSize - 1; j >= 0; j--) {
                result.add(result.get(j) + leadingBit);
            }
        }
        return result;
    }
}