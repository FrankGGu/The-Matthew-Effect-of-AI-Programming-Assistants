from typing import List

class Solution:
    def hIndex(self, citations: List[int]) -> int:
        n = len(citations)

        # Create a frequency array (buckets) for citation counts.
        # The maximum possible h-index is n.
        # Any paper with more than n citations effectively contributes to
        # the count of papers with 'n' or more citations when calculating h-index.
        # So, we only need buckets up to n.
        # counts[k] stores the number of papers with exactly k citations.
        # counts[n] stores papers with n or more citations.
        counts = [0] * (n + 1)

        for c in citations:
            if c >= n:
                counts[n] += 1
            else:
                counts[c] += 1

        # Iterate from the highest possible h-index (n) down to 0.
        # 'papers' will accumulate the number of papers that have at least 'h_candidate' citations.
        papers = 0
        for h_candidate in range(n, -1, -1):
            papers += counts[h_candidate]
            # If we have 'papers' papers with at least 'h_candidate' citations,
            # then h_candidate is a valid h-index.
            # Since we iterate downwards, the first one we find will be the maximum.
            if papers >= h_candidate:
                return h_candidate

        # This line should technically not be reached if n >= 1, as h=0 is always a valid h-index
        # (0 papers have at least 0 citations, and the remaining n papers have no more than 0 citations).
        # However, it serves as a fallback.
        return 0