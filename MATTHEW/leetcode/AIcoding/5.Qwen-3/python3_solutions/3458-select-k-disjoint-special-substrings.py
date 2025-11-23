class Solution:
    def kDisjointSpecialSubstrings(self, s: str, k: int) -> List[str]:
        from collections import defaultdict

        n = len(s)
        special = set()
        seen = set()

        for i in range(n):
            for j in range(i + 1, n + 1):
                substr = s[i:j]
                if substr in seen:
                    continue
                if substr == substr[::-1]:
                    special.add(substr)
                    seen.add(substr)

        special = sorted(special, key=lambda x: (len(x), x), reverse=True)
        result = []

        for substr in special:
            if k <= 0:
                break
            if not any(set(substr) & set(res) for res in result):
                result.append(substr)
                k -= 1

        return result