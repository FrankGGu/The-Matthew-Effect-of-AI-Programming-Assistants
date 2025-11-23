class Solution:
    def separateSquares(self, nums: List[int]) -> int:
        squares = []
        non_squares = []
        for num in nums:
            sqrt_num = int(num**0.5)
            if sqrt_num * sqrt_num == num:
                squares.append(num)
            else:
                non_squares.append(num)

        squares.sort()
        non_squares.sort()

        return squares + non_squares