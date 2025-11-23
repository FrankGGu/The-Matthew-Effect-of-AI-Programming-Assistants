class Solution:
    def maximizeArea(self, n: int, m: int, hFences: List[int], vFences: List[int]) -> int:
        hFences.sort()
        vFences.sort()
        hFences = [1] + hFences + [n]
        vFences = [1] + vFences + [m]

        def get_diffs(fences):
            diffs = set()
            for i in range(len(fences)):
                for j in range(i + 1, len(fences)):
                    diffs.add(fences[j] - fences[i])
            return diffs

        h_diffs = get_diffs(hFences)
        v_diffs = get_diffs(vFences)

        max_area = 0
        for h in h_diffs:
            if h in v_diffs:
                max_area = max(max_area, h)

        return max_area % (10**9 + 7) if max_area > 0 else -1