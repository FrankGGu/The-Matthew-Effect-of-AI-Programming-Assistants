import java.util.List;
import java.util.LinkedList;

class Solution {
    public List<Integer> addToArrayForm(int[] num, int k) {
        LinkedList<Integer> result = new LinkedList<>();
        int i = num.length - 1;
        int carry = 0;

        while (i >= 0 || k > 0 || carry > 0) {
            int digitNum = (i >= 0) ? num[i] : 0;
            int digitK = k % 10;

            int sum = digitNum + digitK + carry;
            result.addFirst(sum % 10);
            carry = sum / 10;

            if (i >= 0) {
                i--;
            }
            k /= 10;
        }

        return result;
    }
}