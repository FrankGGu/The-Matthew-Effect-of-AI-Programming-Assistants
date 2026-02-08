class Solution:
    def minOperations(self, s: str) -> int:
        count1 = sum(s[i] != str(i % 2) for i in range(len(s)))
        count2 = sum(s[i] != str((i + 1) % 2) for i in range(len(s)))
        return min(count1, count2)