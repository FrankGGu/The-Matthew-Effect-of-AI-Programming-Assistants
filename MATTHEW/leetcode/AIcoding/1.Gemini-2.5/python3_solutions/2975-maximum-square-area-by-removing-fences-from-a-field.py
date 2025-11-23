class Solution:
    def maximizeSquareArea(self, n: int, m: int, hFences: list[int], vFences: list[int]) -> int:
        MOD = 10**9 + 7

        h_coords = set([1, n + 1])
        h_coords.update(hFences)
        h_coords_list = sorted(list(h_coords))

        h_diffs = set()
        for i in range(len(h_coords_list)):
            for j in range(i + 1, len(h_coords_list)):
                h_diffs.add(h_coords_list[j] - h_coords_list[i])

        v_coords = set([1, m + 1])
        v_coords.update(vFences)
        v_coords_list = sorted(list(v_coords))

        v_diffs = set()
        for i in range(len(v_coords_list)):
            for j in range(i + 1, len(v_coords_list)):
                v_diffs.add(v_coords_list[j] - v_coords_list[i])

        common_sides = h_diffs.intersection(v_diffs)

        if not common_sides:
            return -1

        max_s = 0
        for side in common_sides:
            if side > max_s:
                max_s = side

        return (max_s * max_s) % MOD