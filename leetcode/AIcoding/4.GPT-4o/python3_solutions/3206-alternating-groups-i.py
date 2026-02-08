class Solution:
    def alternatingGroups(self, arr: List[int]) -> List[int]:
        result = []
        for i in range(len(arr)):
            if (i % 2 == 0 and arr[i] % 2 == 0) or (i % 2 == 1 and arr[i] % 2 == 1):
                result.append(arr[i])
        return result