class Solution:
    def substringXorQueries(self, s: str, queries: List[List[int]]) -> List[List[int]]:
        res = []
        val_to_indices = {}
        n = len(s)

        for i in range(n):
            if s[i] == '0':
                if 0 not in val_to_indices:
                    val_to_indices[0] = [i, i]
                continue
            num = 0
            for j in range(i, min(i + 30, n)):
                num = (num << 1) | (1 if s[j] == '1' else 0)
                if num not in val_to_indices:
                    val_to_indices[num] = [i, j]

        for a, b in queries:
            val = a ^ b
            res.append(val_to_indices.get(val, [-1, -1]))

        return res