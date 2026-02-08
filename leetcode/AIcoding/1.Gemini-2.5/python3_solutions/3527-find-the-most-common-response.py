from collections import Counter

class Solution:
    def findMostCommonResponse(self, responses: list[str]) -> str:
        if not responses:
            return ""

        counts = Counter(responses)

        # most_common(1) returns a list containing the single most common element
        # and its count, e.g., [('apple', 3)].
        # [0] accesses this tuple, and [0] of the tuple accesses the element itself.
        most_common_item = counts.most_common(1)[0][0]

        return most_common_item