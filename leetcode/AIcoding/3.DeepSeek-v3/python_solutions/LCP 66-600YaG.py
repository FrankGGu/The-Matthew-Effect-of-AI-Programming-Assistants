class Solution:
    def minBooths(self, demand: List[str]) -> int:
        max_count = [0] * 26
        for s in demand:
            current_count = [0] * 26
            for c in s:
                idx = ord(c) - ord('a')
                current_count[idx] += 1
            for i in range(26):
                if current_count[i] > max_count[i]:
                    max_count[i] = current_count[i]
        return sum(max_count)