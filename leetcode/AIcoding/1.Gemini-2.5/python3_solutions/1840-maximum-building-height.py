class Solution:
    def maxBuilding(self, n: int, restrictions: list[list[int]]) -> int:
        processed_restrictions = []
        processed_restrictions.append([0, 0])
        processed_restrictions.extend(restrictions)
        processed_restrictions.append([n - 1, n - 1]) 

        processed_restrictions.sort()

        unique_restrictions = []
        if processed_restrictions:
            unique_restrictions.append(processed_restrictions[0])
            for i in range(1, len(processed_restrictions)):
                current_idx, current_max_h = processed_restrictions[i]
                prev_idx, prev_max_h = unique_restrictions[-1]
                if current_idx == prev_idx:
                    unique_restrictions[-1][1] = min(prev_max_h, current_max_h)
                else:
                    unique_restrictions.append([current_idx, current_max_h])

        R = unique_restrictions
        m = len(R)

        actual_heights = [0] * m
        actual_heights[0] = 0

        for i in range(1, m):
            idx_curr, max_h_curr = R[i]
            idx_prev, _ = R[i-1]
            actual_heights[i] = min(max_h_curr, actual_heights[i-1] + (idx_curr - idx_prev))

        for i in range(m - 2, -1, -1):
            idx_curr, _ = R[i]
            idx_next, _ = R[i+1]
            actual_heights[i] = min(actual_heights[i], actual_heights[i+1] + (idx_next - idx_curr))

        max_overall_height = 0
        for i in range(m):
            max_overall_height = max(max_overall_height, actual_heights[i])

            if i + 1 < m:
                idx1, h1 = R[i][0], actual_heights[i]
                idx2, h2 = R[i+1][0], actual_heights[i+1]
                dist = idx2 - idx1

                peak_height_between = (h1 + h2 + dist) // 2
                max_overall_height = max(max_overall_height, peak_height_between)

        return max_overall_height