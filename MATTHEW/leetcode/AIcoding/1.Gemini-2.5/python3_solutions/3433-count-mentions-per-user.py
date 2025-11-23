import collections
import re
from typing import List, Dict

class Solution:
    def countMentionsPerUser(self, posts: List[List[str]]) -> Dict[str, int]:
        mention_counts = collections.Counter()

        for author_id, content in posts:
            mentioned_users = re.findall(r"@(\w+)", content)

            for mentioned_user_id in mentioned_users:
                mention_counts[mentioned_user_id] += 1

        return dict(mention_counts)