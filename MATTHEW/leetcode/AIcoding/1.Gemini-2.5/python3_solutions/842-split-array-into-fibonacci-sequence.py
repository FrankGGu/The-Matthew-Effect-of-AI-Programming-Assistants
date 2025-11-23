class Solution:
    def splitIntoFibonacci(self, S: str) -> list[int]:
        self.ans = []

        def backtrack(index, current_list):
            if index == len(S):
                return len(current_list) >= 3

            if len(current_list) < 2:
                for i in range(index, min(index + 10, len(S))):
                    if S[index] == '0' and i > index:
                        break

                    num_str = S[index : i+1]
                    num = int(num_str)

                    if num > 2**31 - 1:
                        break

                    current_list.append(num)
                    if backtrack(i + 1, current_list):
                        return True
                    current_list.pop()
                return False
            else:
                num1 = current_list[-2]
                num2 = current_list[-1]
                expected_num = num1 + num2

                if expected_num > 2**31 - 1:
                    return False

                expected_num_str = str(expected_num)

                if not S[index:].startswith(expected_num_str):
                    return False

                current_list.append(expected_num)
                if backtrack(index + len(expected_num_str), current_list):
                    return True
                current_list.pop()
                return False

        if backtrack(0, self.ans):
            return self.ans
        else:
            return []