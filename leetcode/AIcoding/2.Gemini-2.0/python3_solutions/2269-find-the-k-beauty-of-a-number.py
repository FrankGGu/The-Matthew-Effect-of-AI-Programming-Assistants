class Solution:
    def divisorSubstrings(self, num: int, k: int) -> int:
        s = str(num)
        count = 0
        for i in range(len(s) - k + 1):
            sub = s[i:i+k]
            num_sub = int(sub)
            if num_sub != 0 and num % num_sub == 0:
                count += 1
        return count