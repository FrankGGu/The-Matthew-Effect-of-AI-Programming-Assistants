import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> addToArrayForm(int[] A, int K) {
        List<Integer> result = new ArrayList<>();
        int carry = K;
        int n = A.length;

        for (int i = n - 1; i >= 0 || carry > 0; i--) {
            if (i >= 0) {
                carry += A[i];
            }
            result.add(0, carry % 10);
            carry /= 10;
        }
        return result;
    }
}