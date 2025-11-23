class Solution:
    def rotatedDigits(self, N: int) -> int:
        def is_good(num):
            good = False
            for c in str(num):
                if c in '234579':
                    good = True
                elif c in '01468':
                    continue
                else:
                    return False
            return good

        count = 0
        for i in range(1, N + 1):
            if is_good(i):
                count += 1
        return count