class Solution {
    public int hIndex(int[] citations) {
        int n = citations.length;
        int[] counts = new int[n + 1];
        for (int c : citations) {
            if (c >= n) {
                counts[n]++;
            } else {
                counts[c]++;
            }
        }
        int k = n;
        int s = counts[n];
        while (k > s) {
            k--;
            s += counts[k];
        }
        return k;
    }
}