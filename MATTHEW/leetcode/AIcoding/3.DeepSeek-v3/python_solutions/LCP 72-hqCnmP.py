class Solution:
    def supplyWagon(self, supplies: List[int]) -> List[int]:
        n = len(supplies)
        target = n // 2
        while len(supplies) > target:
            min_sum = float('inf')
            merge_pos = 0
            for i in range(len(supplies) - 1):
                current_sum = supplies[i] + supplies[i + 1]
                if current_sum < min_sum:
                    min_sum = current_sum
                    merge_pos = i
            supplies[merge_pos] = min_sum
            supplies.pop(merge_pos + 1)
        return supplies