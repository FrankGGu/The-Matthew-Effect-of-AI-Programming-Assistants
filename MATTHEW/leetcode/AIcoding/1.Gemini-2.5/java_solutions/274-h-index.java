import java.util.Arrays;

class Solution {
    public int hIndex(int[] citations) {
        Arrays.sort(citations);
        int n = citations.length;

        for (int i = 0; i < n; i++) {
            // h_candidate is the number of papers from current index 'i' to the end.
            // This is (n - 1) - i + 1 = n - i.
            int h_candidate = n - i;

            // If the current paper (citations[i]) has at least h_candidate citations,
            // then all papers from citations[i] to citations[n-1] (which are h_candidate papers)
            // must also have at least citations[i] citations.
            // Since citations[i] >= h_candidate, it means these h_candidate papers
            // all have at least h_candidate citations.
            // This 'h_candidate' is a valid h-index.
            // Because we iterate from the smallest citation to largest,
            // the corresponding 'h_candidate' decreases. The first 'h_candidate'
            // that satisfies the condition will be the maximum possible h-index.
            if (citations[i] >= h_candidate) {
                return h_candidate;
            }
        }

        // If no such h_candidate is found, it means all papers have 0 citations,
        // or very few citations such that no h_candidate satisfies the condition.
        // In this case, the h-index is 0.
        return 0;
    }
}