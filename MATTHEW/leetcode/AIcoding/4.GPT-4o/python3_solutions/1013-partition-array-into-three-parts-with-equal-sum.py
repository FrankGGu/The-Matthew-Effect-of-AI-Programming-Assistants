class Solution:
    def canThreePartsEqualSum(self, A: List[int]) -> bool:
        total = sum(A)
        if total % 3 != 0:
            return False
        part_sum = total // 3
        count = 0
        current_sum = 0

        for num in A:
            current_sum += num
            if current_sum == part_sum:
                count += 1
                current_sum = 0
        return count >= 3