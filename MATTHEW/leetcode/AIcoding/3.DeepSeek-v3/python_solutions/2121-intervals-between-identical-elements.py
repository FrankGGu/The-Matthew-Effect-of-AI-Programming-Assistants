class Solution:
    def getDistances(self, arr: List[int]) -> List[int]:
        from collections import defaultdict
        indices = defaultdict(list)
        for i, num in enumerate(arr):
            indices[num].append(i)

        res = [0] * len(arr)
        for num in indices:
            idx_list = indices[num]
            prefix = [0] * (len(idx_list) + 1)
            for i in range(len(idx_list)):
                prefix[i + 1] = prefix[i] + idx_list[i]

            for i, idx in enumerate(idx_list):
                left_sum = idx * i - prefix[i]
                right_sum = (prefix[len(idx_list)] - prefix[i + 1]) - idx * (len(idx_list) - i - 1)
                res[idx] = left_sum + right_sum

        return res