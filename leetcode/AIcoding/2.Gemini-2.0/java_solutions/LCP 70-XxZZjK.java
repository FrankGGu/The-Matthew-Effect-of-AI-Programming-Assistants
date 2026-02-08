class Solution {
    public int minimumBuckets(String street) {
        int n = street.length();
        int buckets = 0;
        char[] s = street.toCharArray();

        for (int i = 0; i < n; i++) {
            if (s[i] == 'H') {
                if (i > 0 && s[i - 1] == 'B') {
                    continue;
                } else if (i < n - 1 && s[i + 1] == '.') {
                    s[i + 1] = 'B';
                    buckets++;
                } else if (i > 0 && s[i - 1] == '.') {
                    s[i - 1] = 'B';
                    buckets++;
                } else {
                    return -1;
                }
            }
        }

        return buckets;
    }
}