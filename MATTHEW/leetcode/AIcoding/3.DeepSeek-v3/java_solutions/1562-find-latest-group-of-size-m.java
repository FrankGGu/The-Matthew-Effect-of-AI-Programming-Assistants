class Solution {
    public int findLatestStep(int[] arr, int m) {
        int n = arr.length;
        if (n == m) {
            return n;
        }
        TreeSet<Integer> set = new TreeSet<>();
        set.add(0);
        set.add(n + 1);
        for (int i = n - 1; i >= 0; i--) {
            int pos = arr[i];
            int left = set.floor(pos);
            int right = set.ceiling(pos);
            if (pos - left - 1 == m || right - pos - 1 == m) {
                return i;
            }
            set.add(pos);
        }
        return -1;
    }
}