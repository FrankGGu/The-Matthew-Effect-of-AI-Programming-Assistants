import collections
import heapq

class Twitter:
    def __init__(self):
        self.tweet_count = 0
        self.user_tweets = collections.defaultdict(list)
        self.user_follows = collections.defaultdict(set)

    def postTweet(self, userId: int, tweetId: int) -> None:
        self.tweet_count += 1
        self.user_tweets[userId].append((-self.tweet_count, tweetId))

    def getNewsFeed(self, userId: int) -> List[int]:
        heap = []
        for followee in self.user_follows[userId]:
            for tweet in self.user_tweets[followee]:
                heapq.heappush(heap, tweet)
        for tweet in self.user_tweets[userId]:
            heapq.heappush(heap, tweet)
        result = []
        while heap and len(result) < 10:
            result.append(heapq.heappop(heap)[1])
        return result

    def follow(self, userId: int, followerId: int) -> None:
        self.user_follows[userId].add(followerId)

    def unfollow(self, userId: int, followerId: int) -> None:
        if followerId in self.user_follows[userId]:
            self.user_follows[userId].remove(followerId)