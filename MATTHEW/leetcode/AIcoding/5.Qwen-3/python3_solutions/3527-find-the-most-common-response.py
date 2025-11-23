from collections import Counter
from typing import List

class Solution:
    def mostCommonResponse(self, log: List[str]) -> str:
        responses = [s.split()[1] for s in log]
        counts = Counter(responses)
        return max(counts, key=counts.get)