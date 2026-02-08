class Solution:
    def relativeSortArray(self, arr1: list[int], arr2: list[int]) -> list[int]:
        res = []
        remaining = []
        count = {}
        for num in arr1:
            if num in count:
                count[num] += 1
            else:
                count[num] = 1

        for num in arr2:
            if num in count:
                res.extend([num] * count[num])
                del count[num]

        for num in arr1:
            if num in count:
                remaining.append(num)

        remaining.sort()
        res.extend(remaining)

        return res