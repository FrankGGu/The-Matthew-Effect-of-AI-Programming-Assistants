class Solution:
    def relativeSortArray(self, arr1: List[int], arr2: List[int]) -> List[int]:
        count = {num: 0 for num in arr2}
        others = []

        for num in arr1:
            if num in count:
                count[num] += 1
            else:
                others.append(num)

        result = []
        for num in arr2:
            result.extend([num] * count[num])

        result.extend(sorted(others))
        return result