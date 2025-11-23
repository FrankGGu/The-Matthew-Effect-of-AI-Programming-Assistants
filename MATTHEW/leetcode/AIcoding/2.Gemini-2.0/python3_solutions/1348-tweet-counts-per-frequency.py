class TweetCounts:

    def __init__(self):
        self.tweets = {}

    def recordTweet(self, tweetName: str, time: int) -> None:
        if tweetName not in self.tweets:
            self.tweets[tweetName] = []
        self.tweets[tweetName].append(time)
        self.tweets[tweetName].sort()

    def getTweetCountsPerFrequency(self, freq: str, tweetName: str, startTime: int, endTime: int) -> list[int]:
        if tweetName not in self.tweets:
            return []

        if freq == "minute":
            interval = 60
        elif freq == "hour":
            interval = 3600
        else:
            interval = 86400

        result = []

        num_intervals = (endTime - startTime) // interval + 1

        counts = [0] * num_intervals

        for time in self.tweets[tweetName]:
            if startTime <= time <= endTime:
                index = (time - startTime) // interval
                counts[index] += 1

        return counts