class Solution:
    def recoverArray(self, n: int, sums: List[int]) -> List[int]:
        sums.sort()
        total = sums[0]
        original = []
        for k in range(1, n):
            if (n * k) % 2 == 0:
                target = total + (sums[k] - sums[0]) // 2
                if target in sums:
                    original.append(target)
                    sums.remove(target)
                    sums.remove(total - target)
                    total = sums[0]
                else:
                    return []
        return original