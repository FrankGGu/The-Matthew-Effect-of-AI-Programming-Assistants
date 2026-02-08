class Solution:
    def maximizeSquareHoleArea(self, n: int, m: int, hBars: list[int], vBars: list[int]) -> int:
        def get_max_effective_span(bars_list: list[int]) -> int:
            if not bars_list:
                return 1 # If no bars are removed, it means a 1x1 cell is the smallest possible "span" in that dimension, effectively not contributing to a larger hole.
                         # This interpretation is crucial. If `hBars` is empty, `h_span` is 1. If `vBars` is empty, `v_span` is 1.
                         # Then `min(1,1) = 1`. Area 1. This means a 1x1 hole can be formed without removing any bars, which is incorrect.
                         # Let's re-evaluate: if `bars_list` is empty, it means no opening. So the span is 0.
                         # If `get_max_effective_span([])` returns 0, then `min(0, X) = 0`, giving area 0. This is the correct behavior for empty lists.

            bars_list.sort()
            max_consecutive_removed = 1
            current_consecutive_removed = 1

            for i in range(1, len(bars_list)):
                if bars_list[i] == bars_list[i-1] + 1:
                    current_consecutive_removed += 1
                else:
                    current_consecutive_removed = 1
                max_consecutive_removed = max(max_consecutive_removed, current_consecutive_removed)

            # If 'k' consecutive bars are removed, it allows for a span of 'k+1' units.
            return max_consecutive_removed + 1

        # Corrected base case for get_max_effective_span:
        # If no bars are removed in a dimension, no hole can be formed in that dimension.
        # This implies a span of 0.
        def calculate_span(bars_list: list[int]) -> int:
            if not bars_list:
                return 0 # No bars removed, no opening, so span is 0.

            bars_list.sort()
            max_consecutive_removed = 1
            current_consecutive_removed = 1

            for i in range(1, len(bars_list)):
                if bars_list[i] == bars_list[i-1] + 1:
                    current_consecutive_removed += 1
                else:
                    current_consecutive_removed = 1
                max_consecutive_removed = max(max_consecutive_removed, current_consecutive_removed)

            # If 'k' consecutive bars are removed, it allows for a span of 'k+1' units.
            return max_consecutive_removed + 1

        h_span = calculate_span(hBars)
        v_span = calculate_span(vBars)

        side = min(h_span, v_span)
        return side * side