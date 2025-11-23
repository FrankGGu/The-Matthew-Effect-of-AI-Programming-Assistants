class Solution:
    def count_mentions_per_user(self, tweets: List[str]) -> List[int]:
        from collections import defaultdict

        mention_count = defaultdict(int)

        for tweet in tweets:
            words = tweet.split()
            for word in words:
                if word.startswith('@'):
                    mention_count[word] += 1

        return [mention_count[tweet] for tweet in tweets]