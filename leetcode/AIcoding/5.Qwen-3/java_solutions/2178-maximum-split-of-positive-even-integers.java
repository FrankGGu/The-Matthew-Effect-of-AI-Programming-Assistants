public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Long> splitEvenNumber(long n) {
        List<Long> result = new ArrayList<>();
        if (n % 2 != 0) {
            return result;
        }
        long half = n / 2;
        result.add(half);
        result.add(half);
        return result;
    }
}
}