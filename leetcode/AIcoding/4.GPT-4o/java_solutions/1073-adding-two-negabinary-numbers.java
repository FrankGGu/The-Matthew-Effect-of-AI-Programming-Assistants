public class Solution {
    public int[] addNegabinary(int[] arr1, int[] arr2) {
        int len1 = arr1.length, len2 = arr2.length;
        int maxLen = Math.max(len1, len2);
        int[] result = new int[maxLen + 2];
        int carry = 0;

        for (int i = 0; i < maxLen || carry != 0; i++) {
            if (i < len1) carry += arr1[len1 - 1 - i];
            if (i < len2) carry += arr2[len2 - 1 - i];
            result[result.length - 1 - i] = (carry + 2) % 2; 
            carry = (carry < 0) ? -1 : (carry > 1 ? 1 : 0);
        }

        if (result[0] == 0) {
            int[] newResult = new int[result.length - 1];
            System.arraycopy(result, 1, newResult, 0, newResult.length);
            return newResult;
        }
        return result;
    }
}