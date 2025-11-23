class Solution:
    def threeEqualParts(self, arr: List[int]) -> List[int]:
        total = sum(arr)
        if total % 3 != 0:
            return [-1, -1]
        if total == 0:
            return [0, 2]
        k = total // 3
        first = second = third = -1
        count = 0
        for i in range(len(arr)):
            if arr[i] == 1:
                count += 1
                if count == k:
                    first = i
                elif count == 2 * k:
                    second = i
                elif count == 3 * k:
                    third = i
        n = len(arr)
        if third == -1:
            return [-1, -1]
        if n - third < third - second or n - third < second - first:
            return [-1, -1]
        i = first
        j = second
        l = third
        while l < n:
            if arr[i] != arr[j] or arr[i] != arr[l]:
                return [-1, -1]
            i += 1
            j += 1
            l += 1
        return [first, second + 1]