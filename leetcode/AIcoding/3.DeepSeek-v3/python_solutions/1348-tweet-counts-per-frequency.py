from collections import defaultdict
import bisect

class TweetCounts:

    def __init__(self):
        self.tweets = defaultdict(list)

    def recordTweet(self, tweetName: str, time: int) -> None:
        bisect.insort(self.tweets[tweetName], time)

    def getTweetCountsPerFrequency(self, freq: str, tweetName: str, startTime: int, endTime: int) -> List[int]:
        delta = 60 if freq == 'minute' else 3600 if freq == 'hour' else 86400
        res = []
        times = self.tweets[tweetName]
        i = startTime
        while i <= endTime:
            j = min(i + delta, endTime + 1)
            left = bisect.bisect_left(times, i)
            right = bisect.bisect_left(times, j)
            res.append(right - left)
            i = j
        return res