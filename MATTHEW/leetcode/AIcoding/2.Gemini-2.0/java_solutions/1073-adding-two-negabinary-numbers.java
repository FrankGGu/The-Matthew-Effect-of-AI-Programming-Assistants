class Solution {
    public int[] addNegabinary(int[] arr1, int[] arr2) {
        List<Integer> result = new ArrayList<>();
        int i = arr1.length - 1, j = arr2.length - 1, carry = 0;
        while (i >= 0 || j >= 0 || carry != 0) {
            int sum = carry;
            if (i >= 0) {
                sum += arr1[i--];
            }
            if (j >= 0) {
                sum += arr2[j--];
            }

            if (sum >= 2) {
                result.add(sum - 2);
                carry = -1;
            } else if (sum == 1) {
                result.add(1);
                carry = 0;
            } else if (sum == 0) {
                result.add(0);
                carry = 0;
            } else {
                result.add(1);
                carry = 1;
            }
        }

        while (result.size() > 1 && result.get(result.size() - 1) == 0) {
            result.remove(result.size() - 1);
        }

        int[] res = new int[result.size()];
        for (int k = 0; k < result.size(); k++) {
            res[k] = result.get(result.size() - 1 - k);
        }
        return res;
    }
}