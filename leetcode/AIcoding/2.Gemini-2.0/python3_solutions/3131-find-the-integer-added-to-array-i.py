class Solution:
    def addToArrayForm(self, num: List[int], k: int) -> List[int]:
        num_int = 0
        for digit in num:
            num_int = num_int * 10 + digit

        sum_int = num_int + k

        if sum_int == 0:
            return [0]

        result = []
        while sum_int > 0:
            result.insert(0, sum_int % 10)
            sum_int //= 10

        return result