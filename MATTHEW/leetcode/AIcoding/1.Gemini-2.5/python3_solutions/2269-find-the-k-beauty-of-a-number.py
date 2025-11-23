class Solution:
    def divisorSubstrings(self, num: int, k: int) -> int:
        s = str(num)
        n = len(s)
        k_beauty_count = 0

        for i in range(n - k + 1):
            substring = s[i : i + k]
            sub_num = int(substring)

            if sub_num != 0 and num % sub_num == 0:
                k_beauty_count += 1

        return k_beauty_count