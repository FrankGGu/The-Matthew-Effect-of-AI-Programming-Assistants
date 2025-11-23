from collections import defaultdict

class Solution:
    def findRecommendationPairs(self, transactions: list[list[int]]) -> list[list[int]]:
        user_products = defaultdict(set)
        for user_id, product_id in transactions:
            user_products[user_id].add(product_id)

        recommendation_pairs = set()
        for products_set in user_products.values():
            if len(products_set) < 2:
                continue

            product_list = sorted(list(products_set))

            for i in range(len(product_list)):
                for j in range(i + 1, len(product_list)):
                    p1, p2 = product_list[i], product_list[j]
                    recommendation_pairs.add((p1, p2))

        result = sorted([list(pair) for pair in recommendation_pairs])

        return result