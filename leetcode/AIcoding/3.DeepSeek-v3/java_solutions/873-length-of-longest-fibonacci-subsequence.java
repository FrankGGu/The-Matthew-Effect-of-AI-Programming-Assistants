class Solution {
    public int lenLongestFibSubseq(int[] arr) {
        int n = arr.length;
        Set<Integer> set = new HashSet<>();
        for (int num : arr) {
            set.add(num);
        }
        int maxLen = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int x = arr[i], y = arr[j];
                int len = 2;
                while (set.contains(x + y)) {
                    int z = x + y;
                    x = y;
                    y = z;
                    len++;
                }
                if (len > 2) {
                    maxLen = Math.max(maxLen, len);
                }
            }
        }
        return maxLen;
    }
}