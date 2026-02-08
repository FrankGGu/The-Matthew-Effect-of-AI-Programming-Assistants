class Solution:
    def peopleIndexes(self, favoriteCompanies: List[List[str]]) -> List[int]:
        unique_indexes = []
        companies_sets = [set(companies) for companies in favoriteCompanies]

        for i in range(len(companies_sets)):
            is_subset = False
            for j in range(len(companies_sets)):
                if i != j and companies_sets[i].issubset(companies_sets[j]):
                    is_subset = True
                    break
            if not is_subset:
                unique_indexes.append(i)

        return unique_indexes