public class Solution {
    public int[] addNegabinary(int[] a, int[] b) {
        int i = a.length - 1, j = b.length - 1;
        int carry = 0;
        int[] result = new int[20];
        int index = 0;

        while (i >= 0 || j >= 0 || carry != 0) {
            int sum = carry;
            if (i >= 0) sum += a[i--];
            if (j >= 0) sum += b[j--];

            result[index++] = sum & 1;
            carry = -(sum >> 1);
        }

        int[] finalResult = new int[index];
        for (int k = 0; k < index; k++) {
            finalResult[k] = result[index - 1 - k];
        }
        return finalResult;
    }
}