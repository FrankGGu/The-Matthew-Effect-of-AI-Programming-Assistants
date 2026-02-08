class Solution:
    def distributeElements(self, nums: List[int], k: int) -> List[int]:
        arr1 = []
        arr2 = []
        for num in nums:
            if len(arr1) == 0:
                arr1.append(num)
            elif arr1[-1] <= num:
                arr1.append(num)
            elif len(arr2) < k:
                arr2.append(num)
            else:
                arr1.append(num)
        return arr1 + arr2