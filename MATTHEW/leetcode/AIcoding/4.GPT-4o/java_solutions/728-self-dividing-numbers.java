import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> selfDividingNumbers(int left, int right) {
        List<Integer> result = new ArrayList<>();
        for (int i = left; i <= right; i++) {
            if (isSelfDividing(i)) {
                result.add(i);
            }
        }
        return result;
    }

    private boolean isSelfDividing(int number) {
        int original = number;
        while (number > 0) {
            int digit = number % 10;
            if (digit == 0 || original % digit != 0) {
                return false;
            }
            number /= 10;
        }
        return true;
    }
}