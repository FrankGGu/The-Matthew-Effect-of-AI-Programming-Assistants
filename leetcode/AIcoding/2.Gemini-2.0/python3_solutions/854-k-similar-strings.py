import collections

class Solution:
    def kSimilarity(self, s1: str, s2: str) -> int:
        if s1 == s2:
            return 0

        q = collections.deque([(s1, 0)])
        visited = {s1}

        while q:
            curr_s, curr_moves = q.popleft()

            if curr_s == s2:
                return curr_moves

            i = 0
            while curr_s[i] == s2[i]:
                i += 1

            for j in range(i + 1, len(s1)):
                if curr_s[j] == s2[i] and curr_s[j] != s2[j]:
                    new_s = list(curr_s)
                    new_s[i], new_s[j] = new_s[j], new_s[i]
                    new_s = "".join(new_s)

                    if new_s not in visited:
                        q.append((new_s, curr_moves + 1))
                        visited.add(new_s)

        return -1