class Solution:
    def isAdditiveNumber(self, num: str) -> bool:
        n = len(num)

        def check(prev1: int, prev2: int, start_idx: int, count: int) -> bool:
            if start_idx == n:
                return count >= 3

            current_sum = prev1 + prev2
            s_sum = str(current_sum)

            if not num.startswith(s_sum, start_idx):
                return False

            return check(prev2, current_sum, start_idx + len(s_sum), count + 1)

        for i in range(1, n):
            s1 = num[0:i]
            if len(s1) > 1 and s1[0] == '0':
                break

            n1 = int(s1)

            for j in range(i + 1, n):
                s2 = num[i:j]
                if len(s2) > 1 and s2[0] == '0':
                    break

                n2 = int(s2)

                if check(n1, n2, j, 2):
                    return True

        return False