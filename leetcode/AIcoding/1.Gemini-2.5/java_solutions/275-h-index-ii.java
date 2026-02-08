class Solution {
    public int hIndex(int[] citations) {
        int n = citations.length;
        if (n == 0) {
            return 0;
        }

        int left = 0;
        int right = n - 1;
        int h_index = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            // The number of papers with at least citations[mid] citations is n - mid.
            // If citations[mid] is greater than or equal to this count,
            // then n - mid is a potential H-index. We try to find a larger one by
            // looking at papers with more citations (to the left, which means a smaller mid,
            // and thus a larger n - mid).
            if (citations[mid] >= (n - mid)) {
                h_index = n - mid;
                right = mid - 1;
            } else {
                // citations[mid] is too small to be an H-index for n - mid papers.
                // We need papers with more citations, so move to the right half.
                left = mid + 1;
            }
        }

        return h_index;
    }
}