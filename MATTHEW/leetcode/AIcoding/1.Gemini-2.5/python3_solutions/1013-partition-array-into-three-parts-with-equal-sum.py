class Solution:
    def canThreePartsEqualSum(self, arr: list[int]) -> bool:
        total_sum = sum(arr)

        if total_sum % 3 != 0:
            return False

        target_sum = total_sum // 3

        current_sum = 0
        found_partitions = 0

        for num in arr:
            current_sum += num
            if current_sum == target_sum:
                found_partitions += 1
                current_sum = 0

        return found_partitions >= 3