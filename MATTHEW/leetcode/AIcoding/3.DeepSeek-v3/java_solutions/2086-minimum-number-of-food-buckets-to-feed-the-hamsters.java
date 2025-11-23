class Solution {
    public int minimumBuckets(String hamsters) {
        int n = hamsters.length();
        int buckets = 0;
        char[] arr = hamsters.toCharArray();

        for (int i = 0; i < n; i++) {
            if (arr[i] == 'H') {
                if (i > 0 && arr[i - 1] == 'B') {
                    continue;
                }
                if (i < n - 1 && arr[i + 1] == '.') {
                    arr[i + 1] = 'B';
                    buckets++;
                } else if (i > 0 && arr[i - 1] == '.') {
                    arr[i - 1] = 'B';
                    buckets++;
                } else {
                    return -1;
                }
            }
        }
        return buckets;
    }
}