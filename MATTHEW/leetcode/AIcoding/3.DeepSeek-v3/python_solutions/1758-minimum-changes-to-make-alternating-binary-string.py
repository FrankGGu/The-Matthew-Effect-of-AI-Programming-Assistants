class Solution:
    def minOperations(self, s: str) -> int:
        count1 = 0  # starts with '0'
        count2 = 0  # starts with '1'

        for i in range(len(s)):
            current_char = s[i]
            if i % 2 == 0:
                if current_char != '0':
                    count1 += 1
                if current_char != '1':
                    count2 += 1
            else:
                if current_char != '1':
                    count1 += 1
                if current_char != '0':
                    count2 += 1

        return min(count1, count2)