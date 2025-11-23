class Solution:
    def threeEqualParts(self, arr: List[int]) -> List[int]:
        ones = sum(arr)
        if ones % 3 != 0:
            return [-1, -1]
        if ones == 0:
            return [0, 2]

        target_ones = ones // 3
        first_start = -1
        second_start = -1
        third_start = -1
        count = 0
        for i in range(len(arr)):
            if arr[i] == 1:
                count += 1
                if count == 1:
                    first_start = i
                if count == target_ones + 1:
                    second_start = i
                if count == 2 * target_ones + 1:
                    third_start = i

        while third_start < len(arr) and arr[first_start] == arr[second_start] == arr[third_start]:
            first_start += 1
            second_start += 1
            third_start += 1

        if third_start == len(arr):
            return [first_start - 1, second_start]
        else:
            return [-1, -1]