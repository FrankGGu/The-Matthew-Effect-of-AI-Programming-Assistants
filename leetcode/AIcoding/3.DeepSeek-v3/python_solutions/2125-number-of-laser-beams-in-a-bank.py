class Solution:
    def numberOfBeams(self, bank: List[str]) -> int:
        prev = 0
        total = 0
        for row in bank:
            current = row.count('1')
            if current > 0:
                total += prev * current
                prev = current
        return total