class Solution {
    public String smallestString(String s, int k) {
        char[] arr = s.toCharArray();
        for (int i = 0; i < arr.length && k > 0; i++) {
            if (arr[i] != 'a') {
                int change = Math.min(k, arr[i] - 'a');
                arr[i] -= change;
                k -= change;
            }
        }
        return new String(arr);
    }
}