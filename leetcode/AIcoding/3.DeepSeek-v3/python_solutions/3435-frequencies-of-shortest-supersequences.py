import collections

class Solution:
    def shortestSeq(self, big: List[int], small: List[int]) -> List[int]:
        if not big or not small:
            return []

        small_set = set(small)
        required = len(small_set)
        formed = 0
        window_counts = collections.defaultdict(int)
        res = []
        left = 0
        min_len = float('inf')

        for right, num in enumerate(big):
            if num in small_set:
                window_counts[num] += 1
                if window_counts[num] == 1:
                    formed += 1

            while formed == required:
                current_len = right - left + 1
                if current_len < min_len:
                    min_len = current_len
                    res = [left, right]

                left_num = big[left]
                if left_num in small_set:
                    window_counts[left_num] -= 1
                    if window_counts[left_num] == 0:
                        formed -= 1
                left += 1

        return res if min_len != float('inf') else []