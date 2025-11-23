class Solution:
    def peopleWhoseListIsNotSubset(self, favoriteCompanies: list[list[str]]) -> list[int]:
        n = len(favoriteCompanies)
        fav_sets = [set(companies) for companies in favoriteCompanies]

        result = []
        for i in range(n):
            is_subset_of_another = False
            for j in range(n):
                if i == j:
                    continue
                if fav_sets[i].issubset(fav_sets[j]):
                    is_subset_of_another = True
                    break

            if not is_subset_of_another:
                result.append(i)

        return result