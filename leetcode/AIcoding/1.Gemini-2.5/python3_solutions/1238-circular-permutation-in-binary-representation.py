class Solution:
    def circularPermutation(self, n: int, start: int) -> list[int]:
        result = []
        num_elements = 1 << n

        for i in range(num_elements):
            gray_code = i ^ (i >> 1)
            permuted_value = gray_code ^ start
            result.append(permuted_value)

        return result