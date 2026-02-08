import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public List<Integer> addToArrayForm(int[] num, int k) {
        List<Integer> result = new ArrayList<>();
        int n = num.length;
        int carry = 0;
        for (int i = n - 1; i >= 0 || k > 0 || carry > 0; i--) {
            int digitNum = (i >= 0) ? num[i] : 0;
            int digitK = k % 10;
            k /= 10;

            int sum = digitNum + digitK + carry;
            result.add(sum % 10);
            carry = sum / 10;
        }
        Collections.reverse(result);
        return result;
    }
}