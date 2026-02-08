class Solution:
    def digitSum(self, s: str, k: int) -> str:
        while len(s) > k:
            new_s = ""
            i = 0
            while i < len(s):
                group_sum = 0
                j = 0
                while i + j < len(s) and j < k:
                    group_sum += int(s[i + j])
                    j += 1
                new_s += str(group_sum)
                i += j
            s = new_s
        return s