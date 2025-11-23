import collections

class TweetCounts:

    def __init__(self):
        self.tweets = collections.defaultdict(list)
        self.freq_map = {
            "minute": 60,
            "hour": 3600,
            "day": 86400
        }

    def recordTweet(self, tweetName: str, time: int) -> None:
        self.tweets[tweetName].append(time)

    def getTweetCountsPerFrequency(self, freq: str, tweetName: str, startTime: int, endTime: int) -> list[int]:
        interval_size = self.freq_map[freq]

        num_intervals = (endTime - startTime) // interval_size + 1

        counts = [0] * num_intervals

        times = self.tweets[tweetName]

        for t in times:
            if startTime <= t <= endTime:
                interval_index = (t - startTime) // interval_size
                counts[interval_index] += 1

        return counts