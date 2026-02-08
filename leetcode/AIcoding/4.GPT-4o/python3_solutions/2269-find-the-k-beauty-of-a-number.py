class Solution:
    def kBeauty(self, num: int, k: int) -> int:
        num_str = str(num)
        n = len(num_str)
        k_beauty_count = 0

        for i in range(n - k + 1):
            substring = num_str[i:i + k]
            if substring != '0' and num % int(substring) == 0:
                k_beauty_count += 1

        return k_beauty_count