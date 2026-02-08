class Solution:
    def threeEqualParts(self, arr: list[int]) -> list[int]:
        total_ones = sum(arr)
        n = len(arr)

        if total_ones == 0:
            if n < 3:
                return [-1, -1]
            return [0, n - 1]

        if total_ones % 3 != 0:
            return [-1, -1]

        k = total_ones // 3

        ones_indices = [idx for idx, val in enumerate(arr) if val == 1]

        idx1 = ones_indices[k - 1]
        idx2 = ones_indices[2 * k - 1]
        idx3 = ones_indices[3 * k - 1]

        trailing_zeros = n - 1 - idx3

        i = idx1 + trailing_zeros
        j = idx2 + trailing_zeros + 1

        len_segment = trailing_zeros + 1

        if not (arr[idx1 : idx1 + len_segment] == arr[idx2 : idx2 + len_segment] == arr[idx3 : idx3 + len_segment]):
            return [-1, -1]

        return [i, j]