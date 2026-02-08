class Solution:
    def mctFromLeafValues(self, arr: List[int]) -> int:
        stack = []
        result = 0
        arr.append(float('inf'))

        for num in arr:
            while stack and stack[-1] <= num:
                mid = stack.pop()
                if stack:
                    result += mid * min(stack[-1], num)
                else:
                    result += mid * num
            stack.append(num)

        return result