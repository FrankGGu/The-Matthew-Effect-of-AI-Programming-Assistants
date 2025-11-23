from typing import List

class Solution:
    def minNumberOperations(self, target: List[int]) -> int:
        operations = 0
        prev_height = 0
        for current_height in target:
            if current_height > prev_height:
                operations += (current_height - prev_height)
            prev_height = current_height
        return operations