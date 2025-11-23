import math

class Solution:
    def shortestSuperstring(self, words: list[str]) -> str:
        n = len(words)

        overlaps = [[0] * n for _ in range(n)]
        for i in range(n):
            for j in range(n):
                if i == j:
                    continue
                s1 = words[i]
                s2 = words[j]

                for k in range(min(len(s1), len(s2)), 0, -1):
                    if s1[len(s1) - k:] == s2[:k]:
                        overlaps[i][j] = k
                        break

        dp = [[math.inf] * n for _ in range(1 << n)]
        parent = [[-1] * n for _ in range(1 << n)]

        for i in range(n):
            dp[1 << i][i] = len(words[i])

        for mask in range(1, 1 << n):
            for i in range(n):
                if not (mask & (1 << i)):
                    continue

                prev_mask = mask ^ (1 << i)

                if prev_mask == 0:
                    continue

                for j in range(n):
                    if not (prev_mask & (1 << j)):
                        continue

                    current_length = dp[prev_mask][j] + len(words[i]) - overlaps[j][i]

                    if current_length < dp[mask][i]:
                        dp[mask][i] = current_length
                        parent[mask][i] = j

        min_len = math.inf
        last_idx = -1
        final_mask = (1 << n) - 1

        for i in range(n):
            if dp[final_mask][i] < min_len:
                min_len = dp[final_mask][i]
                last_idx = i

        path = []
        current_mask = final_mask
        current_idx = last_idx

        while current_mask > 0:
            path.append(current_idx)
            prev_idx = parent[current_mask][current_idx]
            current_mask ^= (1 << current_idx)
            current_idx = prev_idx

        path.reverse()

        result = words[path[0]]
        for k in range(1, n):
            prev_word_idx = path[k-1]
            current_word_idx = path[k]
            overlap_len = overlaps[prev_word_idx][current_word_idx]
            result += words[current_word_idx][overlap_len:]

        return result