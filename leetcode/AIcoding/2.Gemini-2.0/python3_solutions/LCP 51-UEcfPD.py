class Solution:
    def perfectMenu(self, materials: List[int], cookbooks: List[List[int]], attribute: List[List[int]], limit: int) -> int:
        n = len(cookbooks)
        ans = -1

        def check(mask):
            needs = [0] * 5
            score = 0
            for i in range(n):
                if (mask >> i) & 1:
                    for j in range(5):
                        needs[j] += cookbooks[i][j]
                    score += attribute[i][1]

            for i in range(5):
                if needs[i] > materials[i]:
                    return -1

            flavor = 0
            for i in range(n):
                if (mask >> i) & 1:
                    flavor += attribute[i][0]

            if flavor >= limit:
                return score
            else:
                return -1

        for mask in range(1 << n):
            cur = check(mask)
            if cur != -1:
                ans = max(ans, cur)

        return ans