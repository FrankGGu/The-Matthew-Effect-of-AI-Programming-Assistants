import collections

class Solution:
    def countMentions(self, posts: List[List[str]]) -> Dict[str, int]:
        mention_count = collections.defaultdict(int)
        for post in posts:
            user, content = post
            words = content.split()
            for word in words:
                if word.startswith('@'):
                    mentioned_user = word[1:]
                    if mentioned_user != user:
                        mention_count[mentioned_user] += 1
        return dict(mention_count)