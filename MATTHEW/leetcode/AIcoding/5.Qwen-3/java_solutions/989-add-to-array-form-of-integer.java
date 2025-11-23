public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> addToArrayForm(int[] num, int k) {
        List<Integer> result = new ArrayList<>();
        int i = num.length - 1;
        int carry = 0;

        while (i >= 0 || k > 0) {
            int sum = carry;
            if (i >= 0) {
                sum += num[i];
                i--;
            }
            if (k > 0) {
                sum += k % 10;
                k /= 10;
            }
            result.add(0, sum % 10);
            carry = sum / 10;
        }

        if (carry > 0) {
            result.add(0, carry);
        }

        return result;
    }
}
}