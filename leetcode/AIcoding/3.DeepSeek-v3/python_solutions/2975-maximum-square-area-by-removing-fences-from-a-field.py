class Solution:
    def maximizeSquareArea(self, m: int, n: int, hFences: List[int], vFences: List[int]) -> int:
        MOD = 10**9 + 7

        hFences = [1] + hFences + [m]
        vFences = [1] + vFences + [n]

        hFences.sort()
        vFences.sort()

        h_gaps = set()
        for i in range(len(hFences)):
            for j in range(i + 1, len(hFences)):
                h_gaps.add(hFences[j] - hFences[i])

        v_gaps = set()
        for i in range(len(vFences)):
            for j in range(i + 1, len(vFences)):
                v_gaps.add(vFences[j] - vFences[i])

        common = h_gaps & v_gaps
        if not common:
            return -1
        max_side = max(common)
        return (max_side * max_side) % MOD