class Solution:
    def twoOutOfThree(self, nums1: List[int], nums2: List[int], nums3: List[int]) -> List[int]:
        counts = {}

        for num in set(nums1):
            counts[num] = counts.get(num, 0) + 1

        for num in set(nums2):
            counts[num] = counts.get(num, 0) + 1

        for num in set(nums3):
            counts[num] = counts.get(num, 0) + 1

        result = []
        for num, count in counts.items():
            if count >= 2:
                result.append(num)

        return result