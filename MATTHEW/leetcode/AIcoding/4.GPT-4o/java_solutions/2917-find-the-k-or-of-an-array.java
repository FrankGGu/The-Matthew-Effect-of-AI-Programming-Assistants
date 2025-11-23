class Solution {
    public int findKth(int[] arr, int k) {
        int result = 0;
        for (int num : arr) {
            result ^= num;
        }
        return result ^ k;
    }
}