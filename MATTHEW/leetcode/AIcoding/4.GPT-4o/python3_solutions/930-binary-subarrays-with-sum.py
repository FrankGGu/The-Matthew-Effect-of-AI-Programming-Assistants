class Solution:
    def numSubarraysWithSum(self, A: List[int], S: int) -> int:
        count = {0: 1}
        total = 0
        current_sum = 0

        for num in A:
            current_sum += num
            if current_sum - S in count:
                total += count[current_sum - S]
            count[current_sum] = count.get(current_sum, 0) + 1

        return total