class Solution:
    def distinctDifferenceArray(self, nums: List[int]) -> List[int]:
        result = []
        left_count = {}
        right_count = {}

        for num in nums:
            right_count[num] = right_count.get(num, 0) + 1

        for num in nums:
            left_count[num] = left_count.get(num, 0) + 1
            right_count[num] -= 1

            if right_count[num] == 0:
                del right_count[num]

            result.append(len(left_count) - len(right_count))

        return result