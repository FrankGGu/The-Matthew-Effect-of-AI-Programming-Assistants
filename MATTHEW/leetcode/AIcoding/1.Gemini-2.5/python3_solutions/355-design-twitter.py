import collections
import heapq

class Twitter:

    def __init__(self):
        self.time = 0
        self.tweets = collections.defaultdict(list)
        self.followers = collections.defaultdict(set)

    def postTweet(self, userId: int, tweetId: int) -> None:
        self.tweets[userId].append((self.time, tweetId))
        self.time += 1

    def getNewsFeed(self, userId: int) -> list[int]:
        feed = []

        followed_users = self.followers[userId].copy()
        followed_users.add(userId) 

        heap = [] 

        for f_user in followed_users:
            if f_user in self.tweets and self.tweets[f_user]:
                latest_tweet_index = len(self.tweets[f_user]) - 1
                timestamp, tweetId = self.tweets[f_user][latest_tweet_index]
                heapq.heappush(heap, (-timestamp, tweetId, f_user, latest_tweet_index - 1))

        while heap and len(feed) < 10:
            neg_ts, tweetId, f_user, next_tweet_index = heapq.heappop(heap)
            feed.append(tweetId)

            if next_tweet_index >= 0:
                timestamp, tweetId = self.tweets[f_user][next_tweet_index]
                heapq.heappush(heap, (-timestamp, tweetId, f_user, next_tweet_index - 1))

        return feed

    def follow(self, followerId: int, followeeId: int) -> None:
        self.followers[followerId].add(followeeId)

    def unfollow(self, followerId: int, followeeId: int) -> None:
        if followeeId in self.followers[followerId]:
            self.followers[followerId].remove(followeeId)