class TweetCounts:

    def __init__(self):
        self.tweets = {}

    def recordTweet(self, tweetName: str, time: int) -> None:
        if tweetName not in self.tweets:
            self.tweets[tweetName] = []
        self.tweets[tweetName].append(time)

    def getTweetCountsPerFrequency(self, freq: str, tweetName: str, start: int, end: int) -> List[int]:
        if tweetName not in self.tweets:
            return []

        intervals = {'minute': 60, 'hour': 3600, 'day': 86400}
        interval = intervals[freq]
        counts = [0] * ((end - start) // interval + 1)

        for time in self.tweets[tweetName]:
            if start <= time <= end:
                counts[(time - start) // interval] += 1

        return counts