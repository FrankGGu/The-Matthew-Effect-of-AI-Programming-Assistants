class Solution:
    def peopleIndexes(self, favoriteCompanies: List[List[str]]) -> List[int]:
        n = len(favoriteCompanies)
        companies = [(set(favoriteCompanies[i]), i) for i in range(n)]
        companies.sort(key=lambda x: -len(x[0]))
        result = set(range(n))
        for i in range(n):
            for j in range(i + 1, n):
                if companies[i][0].issuperset(companies[j][0]):
                    result.discard(companies[j][1])
        return sorted(result)