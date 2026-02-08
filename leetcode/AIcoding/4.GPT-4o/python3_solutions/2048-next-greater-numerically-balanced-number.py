class Solution:
    def nextGreaterBalanced(self, n: int) -> int:
        def is_balanced(num):
            s = str(num)
            return s.count('0') == s.count('1')

        def next_number(num):
            num += 1
            while not is_balanced(num):
                num += 1
            return num

        return next_number(n)