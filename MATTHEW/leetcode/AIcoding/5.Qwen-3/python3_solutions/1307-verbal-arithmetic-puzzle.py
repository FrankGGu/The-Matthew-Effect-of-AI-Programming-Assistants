class Solution:
    def isSolvable(self, words: List[str], result: str) -> bool:
        from collections import defaultdict

        max_len = max(len(word) for word in words + [result])
        if any(len(word) > len(result) for word in words):
            return False

        letters = set()
        for word in words + [result]:
            for c in word:
                letters.add(c)
        letters = list(letters)
        n = len(letters)

        mapping = {}
        used = [False] * 10

        def dfs(i):
            if i == n:
                return check(mapping)
            c = letters[i]
            for d in range(10):
                if not used[d]:
                    if d == 0 and (any(word[0] == c for word in words) or result[0] == c):
                        continue
                    mapping[c] = d
                    used[d] = True
                    if dfs(i + 1):
                        return True
                    used[d] = False
                    del mapping[c]
            return False

        def check(mapping):
            total = 0
            for word in words:
                val = 0
                for c in word:
                    val = val * 10 + mapping[c]
                total += val
            res_val = 0
            for c in result:
                res_val = res_val * 10 + mapping[c]
            return total == res_val

        return dfs(0)