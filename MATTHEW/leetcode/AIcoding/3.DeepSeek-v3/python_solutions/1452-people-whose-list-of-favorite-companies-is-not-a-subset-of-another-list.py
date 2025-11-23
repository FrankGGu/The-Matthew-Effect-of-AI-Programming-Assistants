class Solution:
    def peopleIndexes(self, favoriteCompanies: List[List[str]]) -> List[int]:
        res = []
        n = len(favoriteCompanies)
        sets = [set(comp) for comp in favoriteCompanies]
        for i in range(n):
            is_subset = False
            for j in range(n):
                if i == j:
                    continue
                if sets[i].issubset(sets[j]):
                    is_subset = True
                    break
            if not is_subset:
                res.append(i)
        return res