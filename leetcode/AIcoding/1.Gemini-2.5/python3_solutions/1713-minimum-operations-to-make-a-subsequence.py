import bisect

class Solution:
    def minOperations(self, target: list[int], arr: list[int]) -> int:
        target_map = {num: i for i, num in enumerate(target)}

        sub_arr_indices = []
        for x in arr:
            if x in target_map:
                sub_arr_indices.append(target_map[x])

        tails = []
        for num in sub_arr_indices:
            idx = bisect.bisect_left(tails, num)
            if idx == len(tails):
                tails.append(num)
            else:
                tails[idx] = num

        lis_length = len(tails)

        return len(target) - lis_length