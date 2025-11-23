int hIndex(int* citations, int citationsSize) {
    int n = citationsSize;
    if (n == 0) {
        return 0;
    }

    int low = 0;
    int high = n - 1;
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        // count_papers_at_or_after_mid is the number of papers from index 'mid' to 'n-1'.
        // This represents the 'h' value if citations[mid] meets the condition.
        int count_papers_at_or_after_mid = n - mid;

        if (citations[mid] >= count_papers_at_or_after_mid) {
            // If the citation count at 'mid' is greater than or equal to the number of papers
            // (from 'mid' to 'n-1'), then 'count_papers_at_or_after_mid' is a possible h-index.
            // We store this as a potential answer and try to find a larger h-index.
            // A larger h-index would mean fewer papers (smaller 'count_papers_at_or_after_mid'),
            // which corresponds to a smaller 'mid' index. So, we search in the left half.
            ans = count_papers_at_or_after_mid;
            high = mid - 1;
        } else {
            // If citations[mid] < count_papers_at_or_after_mid,
            // it means that even the paper at 'mid' (which is the lowest cited among the
            // 'count_papers_at_or_after_mid' papers) does not meet the 'h' criteria.
            // We need to consider papers with higher citation counts, which are to the right.
            // So, we search in the right half.
            low = mid + 1;
        }
    }

    return ans;
}