func hIndex(citations []int) int {
    n := len(citations)
    if n == 0 {
        return 0
    }

    low := 0
    high := n - 1
    ans := 0 

    for low <= high {
        mid := low + (high - low) / 2

        // numPapers is the count of papers from index `mid` to `n-1`.
        // These `n - mid` papers all have at least `citations[mid]` citations.
        numPapers := n - mid

        if citations[mid] >= numPapers {
            // If the current paper `citations[mid]` has at least `numPapers` citations,
            // then `numPapers` is a valid h-index.
            // We store this as a potential answer and try to find a larger h-index.
            // A larger h-index would mean a smaller `mid` (more papers), so we search in the left half.
            ans = numPapers
            high = mid - 1
        } else {
            // If `citations[mid]` is less than `numPapers`,
            // it means `numPapers` is too high to be the h-index (because the `mid`-th paper
            // doesn't meet the citation requirement for `numPapers` papers).
            // We need to consider fewer papers, so we search in the right half.
            low = mid + 1
        }
    }
    return ans
}