class Solution:
    def analyzeSubscriptions(self, subscriptions: List[List[int]]) -> List[float]:
        from collections import defaultdict

        user_count = defaultdict(int)
        conversion_count = defaultdict(int)

        for user_id, subscription_type in subscriptions:
            user_count[user_id] += 1
            if subscription_type == 1:
                conversion_count[user_id] += 1

        result = []
        for user_id in sorted(user_count.keys()):
            conversion_rate = conversion_count[user_id] / user_count[user_id] * 100
            result.append(conversion_rate)

        return result