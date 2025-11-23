import bisect

class Solution:
    def minWastedSpace(self, packages: List[int], boxes: List[List[int]]) -> int:
        MOD = 10**9 + 7
        packages.sort()
        prefix = [0]
        for p in packages:
            prefix.append(prefix[-1] + p)

        min_waste = float('inf')

        for supplier in boxes:
            supplier.sort()
            if supplier[-1] < packages[-1]:
                continue
            total = 0
            prev = 0
            for box in supplier:
                idx = bisect.bisect_right(packages, box)
                if idx <= prev:
                    continue
                sum_p = prefix[idx] - prefix[prev]
                cnt = idx - prev
                total += box * cnt - sum_p
                prev = idx
                if prev == len(packages):
                    break
            if prev == len(packages):
                if total < min_waste:
                    min_waste = total

        return min_waste % MOD if min_waste != float('inf') else -1