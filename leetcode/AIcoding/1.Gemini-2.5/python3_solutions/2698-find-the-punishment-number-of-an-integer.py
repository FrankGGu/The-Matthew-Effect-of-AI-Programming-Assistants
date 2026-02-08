class Solution:
    def punishmentNumber(self, n: int) -> int:
        total_punishment = 0

        def check(s: str, target: int) -> bool:
            if target < 0:
                return False

            if not s:
                return target == 0

            for i in range(1, len(s) + 1):
                prefix_str = s[:i]
                prefix_val = int(prefix_str)

                if prefix_val > target:
                    break

                if check(s[i:], target - prefix_val):
                    return True

            return False

        for i in range(1, n + 1):
            square_str = str(i * i)
            if check(square_str, i):
                total_punishment += i * i

        return total_punishment