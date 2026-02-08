class Solution {
    public String maximumNumber(String num, int[] change) {
        char[] arr = num.toCharArray();
        boolean mutated = false;
        for (int i = 0; i < arr.length; i++) {
            int digit = arr[i] - '0';
            if (change[digit] > digit) {
                arr[i] = (char) (change[digit] + '0');
                mutated = true;
            } else if (change[digit] < digit && mutated) {
                break;
            }
        }
        return new String(arr);
    }
}