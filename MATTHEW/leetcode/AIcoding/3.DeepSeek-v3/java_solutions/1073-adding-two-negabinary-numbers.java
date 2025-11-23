class Solution {
    public int[] addNegabinary(int[] arr1, int[] arr2) {
        int i = arr1.length - 1, j = arr2.length - 1;
        int carry = 0;
        List<Integer> result = new ArrayList<>();

        while (i >= 0 || j >= 0 || carry != 0) {
            int num1 = i >= 0 ? arr1[i--] : 0;
            int num2 = j >= 0 ? arr2[j--] : 0;
            int sum = num1 + num2 + carry;
            int remainder = sum % (-2);
            carry = sum / (-2);
            if (remainder < 0) {
                remainder += 2;
                carry += 1;
            }
            result.add(remainder);
        }

        while (result.size() > 1 && result.get(result.size() - 1) == 0) {
            result.remove(result.size() - 1);
        }

        int[] res = new int[result.size()];
        for (int k = 0; k < res.length; k++) {
            res[k] = result.get(res.length - 1 - k);
        }
        return res;
    }
}