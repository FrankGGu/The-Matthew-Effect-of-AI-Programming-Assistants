class Solution:
    def pushDominoes(self, dominoes: str) -> str:
        n = len(dominoes)
        s = list('L' + dominoes + 'R')

        prev_idx = 0
        for curr_idx in range(1, len(s)):
            if s[curr_idx] != '.':
                if s[prev_idx] == 'L' and s[curr_idx] == 'L':
                    for k in range(prev_idx + 1, curr_idx):
                        s[k] = 'L'
                elif s[prev_idx] == 'R' and s[curr_idx] == 'R':
                    for k in range(prev_idx + 1, curr_idx):
                        s[k] = 'R'
                elif s[prev_idx] == 'R' and s[curr_idx] == 'L':
                    left = prev_idx + 1
                    right = curr_idx - 1
                    while left < right:
                        s[left] = 'R'
                        s[right] = 'L'
                        left += 1
                        right -= 1

                prev_idx = curr_idx

        return "".join(s[1:-1])