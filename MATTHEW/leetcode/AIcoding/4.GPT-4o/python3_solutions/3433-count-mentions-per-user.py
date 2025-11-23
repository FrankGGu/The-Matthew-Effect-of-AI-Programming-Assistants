class Solution:
    def countMentions(self, mentions: List[str]) -> List[int]:
        count = defaultdict(int)
        for mention in mentions:
            user = mention[1:]  # Skip the '@' character
            count[user] += 1
        return [count[user] for user in mentions]