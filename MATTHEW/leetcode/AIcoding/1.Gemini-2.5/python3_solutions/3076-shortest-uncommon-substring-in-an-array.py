import math

class Solution:
    def shortestUncommonSubstring(self, arr: list[str]) -> str:
        n = len(arr)

        all_substrings_per_string = [set() for _ in range(n)]

        for i in range(n):
            s = arr[i]
            m = len(s)
            for j in range(m):
                for k in range(j + 1, m + 1):
                    all_substrings_per_string[i].add(s[j:k])

        ans = ""
        min_len = math.inf

        for i in range(n):
            for sub in all_substrings_per_string[i]:

                count = 0
                for j in range(n):
                    if sub in all_substrings_per_string[j]:
                        count += 1

                if count == 1:
                    if len(sub) < min_len:
                        min_len = len(sub)
                        ans = sub
                    elif len(sub) == min_len:
                        ans = min(ans, sub)

        return ans