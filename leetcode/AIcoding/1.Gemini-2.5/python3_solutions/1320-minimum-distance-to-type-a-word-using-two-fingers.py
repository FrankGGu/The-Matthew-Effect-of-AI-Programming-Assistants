import collections

class Solution:
    def minimumDistance(self, word: str) -> int:

        memo = {}

        def get_dist(char_idx1, char_idx2):
            if char_idx1 == -1:
                return 0

            r1, c1 = char_idx1 // 6, char_idx1 % 6
            r2, c2 = char_idx2 // 6, char_idx2 % 6

            return abs(r1 - r2) + abs(c1 - c2)

        def solve(k, f1_char_idx, f2_char_idx):
            if k == len(word):
                return 0

            state = (k, f1_char_idx, f2_char_idx)
            if state in memo:
                return memo[state]

            target_char_idx = ord(word[k]) - ord('A')

            cost1 = get_dist(f1_char_idx, target_char_idx) + solve(k + 1, target_char_idx, f2_char_idx)

            cost2 = get_dist(f2_char_idx, target_char_idx) + solve(k + 1, f1_char_idx, target_char_idx)

            memo[state] = min(cost1, cost2)
            return memo[state]

        return solve(0, -1, -1)