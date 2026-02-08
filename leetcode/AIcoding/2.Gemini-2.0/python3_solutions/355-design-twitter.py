class Twitter:

    def __init__(self):
        self.tweets = []
        self.followers = {}
        self.time = 0

    def postTweet(self, userId: int, tweetId: int) -> None:
        self.tweets.append((self.time, userId, tweetId))
        self.time -= 1

    def getNewsFeed(self, userId: int) -> List[int]:
        followees = self.followers.get(userId, set())
        followees.add(userId)

        news_feed = []
        for time, user, tweet in self.tweets:
            if user in followees:
                news_feed.append((time, tweet))

        news_feed.sort(key=lambda x: x[0])
        return [tweet for time, tweet in news_feed[:10]]

    def follow(self, followerId: int, followeeId: int) -> None:
        if followerId not in self.followers:
            self.followers[followerId] = set()
        self.followers[followerId].add(followeeId)

    def unfollow(self, followerId: int, followeeId: int) -> None:
        if followerId in self.followers and followeeId in self.followers[followerId]:
            self.followers[followerId].remove(followeeId)