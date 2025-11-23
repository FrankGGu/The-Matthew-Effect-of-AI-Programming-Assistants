from typing import List
from collections import Counter

class Solution:
    def intersection(self, arrays: List[List[int]]) -> List[int]:
        count = Counter()
        for arr in arrays:
            unique = set(arr)
            for num in unique:
                count[num] += 1
        result = [num for num in count if count[num] == len(arrays)]
        return sorted(result)