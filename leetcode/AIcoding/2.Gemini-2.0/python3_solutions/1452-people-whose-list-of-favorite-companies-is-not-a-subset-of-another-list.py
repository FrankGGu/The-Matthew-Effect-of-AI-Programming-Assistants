class Solution:
    def peopleIndexes(self, favoriteCompanies: List[List[str]]) -> List[int]:
        n = len(favoriteCompanies)
        sets = [set(companies) for companies in favoriteCompanies]
        res = []
        for i in range(n):
            is_subset = False
            for j in range(n):
                if i != j and sets[i].issubset(sets[j]):
                    is_subset = True
                    break
            if not is_subset:
                res.append(i)
        return res