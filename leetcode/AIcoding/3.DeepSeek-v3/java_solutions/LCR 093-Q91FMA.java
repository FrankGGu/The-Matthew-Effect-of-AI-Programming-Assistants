class Solution {
    public int lenLongestFibSubseq(int[] arr) {
        int n = arr.length;
        int maxLen = 0;
        Set<Integer> set = new HashSet<>();
        for (int num : arr) {
            set.add(num);
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int x = arr[i];
                int y = arr[j];
                int len = 2;
                while (set.contains(x + y)) {
                    int temp = y;
                    y = x + y;
                    x = temp;
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