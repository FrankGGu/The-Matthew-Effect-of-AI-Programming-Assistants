import collections
from itertools import combinations
from typing import List

class Solution:
    def findRecommendationPairs(self, interactions: List[List[int]], k: int) -> List[List[int]]:
        user_categories = collections.defaultdict(set)
        for user_id, category_id in interactions:
            user_categories[user_id].add(category_id)

        pair_counts = collections.defaultdict(int)
        for categories_set in user_categories.values():
            if len(categories_set) < 2:
                continue

            categories = sorted(list(categories_set))

            for c1, c2 in combinations(categories, 2):
                pair_counts[(c1, c2)] += 1

        result = []
        for (c1, c2), count in pair_counts.items():
            if count >= k:
                result.append([c1, c2])

        return result