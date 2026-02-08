class Solution:
    def numSteps(self, s: str) -> int:
        num_list = list(s)
        steps = 0

        while len(num_list) > 1:
            steps += 1
            if num_list[-1] == '0':
                num_list.pop()
            else:
                carry = 1
                i = len(num_list) - 1
                while i >= 0 and carry == 1:
                    if num_list[i] == '0':
                        num_list[i] = '1'
                        carry = 0
                    else:
                        num_list[i] = '0'
                    i -= 1

                if carry == 1:
                    num_list.insert(0, '1')

        return steps