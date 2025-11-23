import heapq
from collections import defaultdict

class Twitter:
    def __init__(self):
        self.followers = defaultdict(set)
        self.tweets = defaultdict(list)
        self.time = 0

    def postTweet(self, userId: int, tweetId: int) -> None:
        self.tweets[userId].append((self.time, tweetId))
        self.time += 1

    def getNewsFeed(self, userId: int) -> List[int]:
        heap = []
        followees = self.followers[userId]
        followees.add(userId)
        for user in followees:
            if user in self.tweets:
                tweets = self.tweets[user]
                for i in range(len(tweets)-1, max(-1, len(tweets)-11)-1, -1):
                    heapq.heappush(heap, tweets[i])
                    if len(heap) > 10:
                        heapq.heappop(heap)
        heap.sort(reverse=True)
        return [tweet[1] for tweet in heap]

    def follow(self, followerId: int, followeeId: int) -> None:
        self.followers[followerId].add(followeeId)

    def unfollow(self, followerId: int, followeeId: int) -> None:
        if followeeId in self.followers[followerId]:
            self.followers[followerId].remove(followeeId)