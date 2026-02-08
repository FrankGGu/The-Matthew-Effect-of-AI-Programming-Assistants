class Solution:
    def getDistances(self, arr: List[int]) -> List[int]:
        indices = defaultdict(list)
        for i, num in enumerate(arr):
            indices[num].append(i)

        result = [0] * len(arr)

        for num, idx_list in indices.items():
            prefix_sum = [0] * (len(idx_list) + 1)
            for i in range(len(idx_list)):
                prefix_sum[i+1] = prefix_sum[i] + idx_list[i]

            for i in range(len(idx_list)):
                result[idx_list[i]] = (idx_list[i] * i - prefix_sum[i]) + (prefix_sum[-1] - prefix_sum[i+1] - idx_list[i] * (len(idx_list) - i - 1))

        return result