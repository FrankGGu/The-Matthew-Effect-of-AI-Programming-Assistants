from collections import defaultdict
import heapq

class Twitter:

    def __init__(self):
        self.time = 0
        self.tweets = defaultdict(list)
        self.followees = defaultdict(set)

    def postTweet(self, userId: int, tweetId: int) -> None:
        self.time += 1
        self.tweets[userId].append((self.time, tweetId))

    def getNewsFeed(self, userId: int) -> List[int]:
        min_heap = []
        for uid in self.followees[userId] | {userId}:
            if uid in self.tweets:
                for tweet in self.tweets[uid]:
                    heapq.heappush(min_heap, tweet)
                    if len(min_heap) > 10:
                        heapq.heappop(min_heap)
        return [tweetId for _, tweetId in sorted(min_heap, reverse=True)]

    def follow(self, followerId: int, followeeId: int) -> None:
        self.followees[followerId].add(followeeId)

    def unfollow(self, followerId: int, followeeId: int) -> None:
        if followeeId in self.followees[followerId]:
            self.followees[followerId].remove(followeeId)