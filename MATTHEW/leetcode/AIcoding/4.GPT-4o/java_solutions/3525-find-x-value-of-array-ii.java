class Solution {
    public int findX(int[] arr1, int[] arr2) {
        int n = arr1.length;
        int m = arr2.length;
        int[] count = new int[1001];

        for (int num : arr1) {
            count[num]++;
        }
        for (int num : arr2) {
            count[num]++;
        }

        for (int i = 0; i < count.length; i++) {
            if (count[i] == 1) {
                return i;
            }
        }
        return -1;
    }
}