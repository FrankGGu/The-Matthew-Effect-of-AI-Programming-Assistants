class Solution:
    def addNegabinary(self, arr1: List[int], arr2: List[int]) -> List[int]:
        def convert_to_decimal(arr):
            num = 0
            for i in range(len(arr)):
                num += arr[i] * (-2) ** i
            return num

        def convert_to_negabinary(num):
            if num == 0:
                return [0]
            result = []
            while num != 0:
                num, remainder = divmod(num, -2)
                if remainder < 0:
                    remainder += 2
                    num += 1
                result.append(remainder)
            return result[::-1]

        num1 = convert_to_decimal(arr1)
        num2 = convert_to_decimal(arr2)
        total = num1 + num2
        return convert_to_negabinary(total)