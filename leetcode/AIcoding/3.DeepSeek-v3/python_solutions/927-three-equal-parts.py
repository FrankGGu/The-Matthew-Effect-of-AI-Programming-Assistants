class Solution:
    def threeEqualParts(self, arr: List[int]) -> List[int]:
        ones = sum(arr)
        if ones == 0:
            return [0, len(arr) - 1]
        if ones % 3 != 0:
            return [-1, -1]
        target = ones // 3
        breaks = []
        count = 0
        for i, num in enumerate(arr):
            if num == 1:
                count += 1
                if count == 1:
                    breaks.append(i)
                if count == target:
                    breaks.append(i)
                    count = 0
        i1, j1, i2, j2, i3, j3 = breaks[0], breaks[1], breaks[2], breaks[3], breaks[4], breaks[5]
        if not (arr[i1:j1+1] == arr[i2:j2+1] == arr[i3:j3+1]):
            return [-1, -1]
        trailing_zeros1 = i2 - j1 - 1
        trailing_zeros2 = i3 - j2 - 1
        trailing_zeros = len(arr) - j3 - 1
        if trailing_zeros1 < trailing_zeros or trailing_zeros2 < trailing_zeros:
            return [-1, -1]
        j1 += trailing_zeros
        j2 += trailing_zeros
        return [j1, j2 + 1]