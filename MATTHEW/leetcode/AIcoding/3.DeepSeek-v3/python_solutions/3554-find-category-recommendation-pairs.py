import collections

class Solution:
    def findRecommendationPairs(self, userPurchases):
        user_items = collections.defaultdict(set)
        item_users = collections.defaultdict(set)

        for user, items in userPurchases.items():
            for item in items:
                user_items[user].add(item)
                item_users[item].add(user)

        pairs = set()

        items = list(item_users.keys())
        n = len(items)

        for i in range(n):
            for j in range(i + 1, n):
                item_a = items[i]
                item_b = items[j]
                users_a = item_users[item_a]
                users_b = item_users[item_b]
                common_users = users_a & users_b
                if len(common_users) >= 3:
                    if (item_a, item_b) not in pairs and (item_b, item_a) not in pairs:
                        pairs.add((item_a, item_b))

        return sorted([sorted(pair) for pair in pairs])